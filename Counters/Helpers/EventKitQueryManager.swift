//
//  EventKitQueryManager.swift
//  Counters
//
//  Created by Thalles Araújo on 17/03/23.
//

import Foundation
import EventKit

class EventKitQueryManager{
    
    var eventStore: EKEventStore = .init()
    
    fileprivate func requestAuthorization(for entity: EKEntityType, _ queryToExecute: @escaping () -> Void){
        
        eventStore.requestAccess(to: entity) { granted, error in
            if let error = error{
                print("Houve um erro ao solicitar acesso aos lembretes/calendário")
                print(error)
            }else{
                if granted{
                    queryToExecute()
                }
            }
        }
    }
    
    func getRemindersCount(completion: @escaping(_ remindersCount: Int) -> Void ){
        let predicate: NSPredicate? = eventStore.predicateForReminders(in: nil)
        if let aPredicate = predicate {
            requestAuthorization(for: .reminder) {
                self.eventStore.fetchReminders(matching: aPredicate, completion: {(_ reminders: [Any]?) -> Void in
                    DispatchQueue.main.async {
                        if let remindersUnwrapped = reminders{
                            let pendingReminders = remindersUnwrapped.compactMap({$0 as? EKReminder}).filter({!$0.isCompleted})
                            completion(pendingReminders.count)
                        }
                    }
                })
            }
        }
    }
    
    
    func getEventCount(completion: @escaping(_ eventCount: Int) -> Void){
        let calendar = Calendar.current
        var nextMonthComponents = DateComponents()
        nextMonthComponents.month = 1
        let nextMonth = calendar.date(byAdding: nextMonthComponents, to: Date())
        
        var predicate: NSPredicate? = nil
        
        if let nextMonthDate = nextMonth{
            predicate = eventStore.predicateForEvents(withStart: Date(), end: nextMonthDate, calendars: nil)
        }
        
        if let predicateUnwrapped = predicate{
            
            requestAuthorization(for: .event) {
                DispatchQueue.main.async {
                    completion(self.eventStore.events(matching: predicateUnwrapped).count)
                }
            }
            
        }
    }
    
    
}
