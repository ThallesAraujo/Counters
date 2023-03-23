//
//  CalendarViewModel.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 23/03/23.
//

import Foundation
import SwiftUI


enum CalendarDataType: String{
    case events = "Eventos"
    case reminders = "Lembretes"
}

struct CalendarData{
    var type: CalendarDataType
    var value: String
}

class CalendarViewModel: ObservableObject{
    
    @Published var calendarData : [CalendarData] = [
        .init(type: .events, value: "0"),
        .init(type: .reminders, value: "0")
    ]
    
    var manager = EventKitQueryManager()
    
    func fetchData(){
        
        let queries = [
            (CalendarDataType.events, manager.getEventCount),
            (CalendarDataType.reminders, manager.getRemindersCount)
        ]
        
        for (type, query) in queries {
            query({count in
                let index = self.calendarData.firstIndex(where: {$0.type == type}).orZero
                self.calendarData[index].value = "\(count)"
            })
        }
    }
    
}

extension Array where Element == CalendarData{
    
    var events: String{
        if let found = self.first(where: {$0.type == .events}){
            return found.value
        }
        return "0"
    }
    
    var reminders: String{
        if let found = self.first(where: {$0.type == .reminders}){
            return found.value
        }
        return "0"
    }
    
}
