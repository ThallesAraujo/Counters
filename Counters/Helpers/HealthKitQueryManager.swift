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
    
    var healthKitTypesToRead: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!,
        HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.appleStandHour)!,
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
    ]
    
    lazy var healthStore = HKHealthStore()
    
    func getCaloriesType(){
        if #available(iOS 14.0, *){
            self.healthKitTypesToRead = [
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
            ]
        }
        
    }
    
    internal func requestAuthorization(_ queryToExecute: @escaping () -> Void){
        
        healthStore.requestAuthorization(toShare: [], read: healthKitTypesToRead) { (success, error) -> Void in
            if success {
                print("success")
                queryToExecute()
            } else {
                print("failure")
            }
            
            if let error = error { print(error) }
        }
        
    }
    
    func getActiveEnergy(completion: @escaping ((_ totalEnergy: Double) -> Void)) {
        
        let energySampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        self.query(unit: HKUnit.kilocalorie(), dataType: energySampleType, completion: completion)
        
    }
    
    func getExerciseTime(completion: @escaping ((_ exerciseTime: Double) -> Void)) {
        
        let exerciseSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        self.query(unit: HKUnit.second(), dataType: exerciseSampleType, completion: completion)
    }
    
    func getStandHour(completion: @escaping ((_ standHour: Double) -> Void)) {
        
        if #available(iOS 14.0, *){
            let standHourSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!
            self.activityQuery(unit: HKUnit.count(), dataType: standHourSampleType, completion: completion)
        }else{
            let standHourSampleType = HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.appleStandHour)!
            self.typedQuery(unit: HKUnit.second(), dataType: standHourSampleType, queryType: .category, completion: completion)
        }
    }
    
    func getStepCount(completion: @escaping ((_ stepCount: Double) -> Void)) {
        
        let stepCountSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        self.query(unit: HKUnit.count(), dataType: stepCountSampleType, completion: completion)
    }
    
    
    internal func typedQuery(currentDate: Date = Date(), unit: HKUnit, dataType: HKSampleType, queryType: QueryType = .quantity, completion: @escaping (Double) -> Void){
        
        self.requestAuthorization{
            let calendar = Calendar.current
            var data = Double()
            //   Get the start of the day
            let startDate: Date = calendar.startOfDay(for: currentDate)
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: currentDate as Date, options: .strictStartDate)
            
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
    
    internal func activityQuery(currentDate: Date = Date(), unit: HKUnit, dataType: HKSampleType, queryType: QueryType = .quantity, completion: @escaping (Double) -> Void){
        
        self.requestAuthorization {
            
            let calendar = Calendar.current
            var data = Double()
            //   Get the start of the day
            let startDate: Date = calendar.startOfDay(for: currentDate)
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: currentDate as Date, options: .strictStartDate)
            
            let query = HKActivitySummaryQuery(predicate: predicate) { query, results, error in
                if results == nil {
                    print("There was an error running the query: \(error.debugDescription)")
                }
                
                DispatchQueue.main.async {
                    
                    if queryType == .quantity{
                        for activity in results!{
                            let dt = activity.appleStandHours.doubleValue(for: unit)
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
            }
            
            self.healthStore.execute(query)
            
        }
        
    }
    
    internal func query(currentDate: Date = Date(), unit: HKUnit, dataType: HKQuantityType, completion: @escaping (Double) -> Void){
        
        self.requestAuthorization {
            let calendar = Calendar.current
            let startDate: Date = calendar.startOfDay(for: currentDate)
            
            var interval = DateComponents()
            interval.day = 1
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: currentDate as Date, options: .strictStartDate)
            
            
            let query = HKStatisticsCollectionQuery(quantityType: dataType,
                                                    quantitySamplePredicate: predicate,
                                                    options: [.cumulativeSum],
                                                    anchorDate: startDate,
                                                    intervalComponents: interval)
            
            
            query.initialResultsHandler = { _, result, error in
                var sum = 0.0
                result?.enumerateStatistics(from: startDate, to: currentDate) { statistics, _ in
                    if let sumQuantity = statistics.sumQuantity() {
                        sum = sumQuantity.doubleValue(for: unit) // Get the step count as Double.
                    }
                    DispatchQueue.main.async {
                        completion(sum)
                    }
                }
            }
            
            query.statisticsUpdateHandler = {
                query, statistics, statisticsCollection, error in
                if let sum = statistics?.sumQuantity() {
                    let resultCount = sum.doubleValue(for: unit)
                    DispatchQueue.main.async {
                        completion(resultCount)
                    }
                }
            }
            
            self.healthStore.execute(query)
        }
        
    }
    
}


