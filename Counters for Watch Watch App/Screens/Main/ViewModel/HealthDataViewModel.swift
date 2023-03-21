//
//  HealthDataViewModel.swift
//  Counters
//
//  Created by Thalles Araújo on 17/03/23.
//

import Foundation
import SwiftUI

enum DataType: String{
    
    case calories = "calories"
    case standHours = "standHours"
    case exerciseTime = "exerciseTime"
    case stepCount = "stepCount"
    
}

class HealthDataViewModel: ObservableObject{
    
    var queryManager = HealthKitQueryManager()
    
    @Published var healthData: [String: String] = [
        "calories": "0",
        "exerciseTime": "0",
        "standHours": "0",
        "stepCount": "0"
    ]
    
    
    init(){
        //Importante: detectar o iOS é 14+
        self.queryManager.getCaloriesType()
    }
    
    func getHealthData(){
        let queries = [
            (self.queryManager.getActiveEnergy, DataType.calories),
            (self.queryManager.getExerciseTime, DataType.exerciseTime),
            (self.queryManager.getStandHour, DataType.standHours),
            (self.queryManager.getStepCount, DataType.stepCount)
        ]
        
        for (query, dataType) in queries{
            query {data in
                
                print("Data: \(dataType): \(data)")
                
                if [DataType.exerciseTime].contains(dataType){
                    self.healthData[dataType.rawValue] = "\(data.asString(style: .abbreviated))"
                }else{
                    self.healthData[dataType.rawValue] = "\(Int(data))"
                }
            }
        }
    }
    
}



