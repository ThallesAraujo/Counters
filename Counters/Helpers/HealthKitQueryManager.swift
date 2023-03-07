//
//  HealthKitQueryManager.swift
//  Counters
//
//  Created by Thalles Araújo on 07/03/23.
//

import Foundation
import HealthKit

class HealthKitQueryManager{
    
    enum QueryType {
        case quantity
        case category
    }
    
    let healthKitTypesToRead: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!,
        HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.appleStandHour)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
    ]
    
    lazy var healthStore = HKHealthStore()
    
    internal func requestAuthorization(_ queryToExecute: @escaping () -> Void){
        
        healthStore.requestAuthorization(toShare: [], read: healthKitTypesToRead) { (success, error) -> Void in
            if success {
                print("success")
                queryToExecute()
            } else {
                print("failure")
            }
            
            if let error = error { print(error)
                
            }
        }
        
    }
    
    func getActiveEnergy(completion: @escaping ((_ totalEnergy: Double) -> Void)) {
        
        let energySampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        self.query(unit: HKUnit.kilocalorie(), dataType: energySampleType, completion: completion)
        
    }
    
    func getExerciseTime(completion: @escaping ((_ exerciseTime: Double) -> Void)) {
        
        let exerciseSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        
        self.query(unit: HKUnit.hour(), dataType: exerciseSampleType, completion: completion)
    }
    
    func getStandHour(completion: @escaping ((_ standHour: Double) -> Void)) {
        
        let standHourSampleType = HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.appleStandHour)!
        
        self.query(unit: HKUnit.hour(), dataType: standHourSampleType, queryType: .category, completion: completion)
    }
    
    func getStepCount(completion: @escaping ((_ stepCount: Double) -> Void)) {
        
        let stepCountSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        self.query(unit: HKUnit.count(), dataType: stepCountSampleType, completion: completion)
    }
    
    
    internal func query(currentDate: Date = Date(), unit: HKUnit, dataType: HKSampleType, queryType: QueryType = .quantity, completion: @escaping (Double) -> Void){
        
        self.requestAuthorization{
            let calendar = Calendar.current
            var data = Double()
            let startOfDay = Int((currentDate.timeIntervalSince1970/86400)+1)*86400
            let startOfDayDate = Date(timeIntervalSince1970: Double(startOfDay))
            //   Get the start of the day
            let newDate = calendar.startOfDay(for: startOfDayDate)
            let startDate: Date = calendar.date(byAdding: Calendar.Component.day, value: -1, to: newDate)!

            //  Set the Predicates
            let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: newDate as Date, options: .strictStartDate)

            //  Perform the Query

            let query = HKSampleQuery(sampleType: dataType, predicate: predicate, limit: 0, sortDescriptors: nil, resultsHandler: {
                (query, results, error) in
                if results == nil {
                    print("There was an error running the query: \(error.debugDescription)")
                }

                DispatchQueue.main.async {
                    
                    if queryType == .quantity{
                        for activity in results as! [HKQuantitySample]{
                            let dt = activity.quantity.doubleValue(for: unit)
                            data = data + dt
                        }
                    }else{
                        for activity in results as! [HKCategorySample]{
                            let dt = Double(activity.value)
                            data = data + dt
                        }
                    }
                    completion(data)
                }
            })
            self.healthStore.execute(query)
        }
        
    }
    
}
