//
//  HealthDataViewModel.swift
//  Counters
//
//  Created by Thalles Araújo on 17/03/23.
//

import Foundation

class HealthDataViewModel{
    
    var dataDidChangeClosure: () -> Void = {}
    var queryManager = HealthKitQueryManager()
    
    var healthData: [HealthData] = [
        .init(type: .calories, data: "0"),
        .init(type: .exerciseTime, data: "0"),
        .init(type: .standHours, data: "0"),
        .init(type: .stepCount, data: "0")
    ]{
        didSet {
            self.dataDidChangeClosure()
        }
    }
    
    
    init(_ dataDidChangeClosure: @escaping () -> Void){
        self.dataDidChangeClosure = dataDidChangeClosure
        //Importante: detectar o iOS é 14+
        self.queryManager.getCaloriesType()
    }
    
    func getHealthData(){
        let queries = [
            (self.queryManager.getActiveEnergy, DataCellType.calories),
            (self.queryManager.getExerciseTime, DataCellType.exerciseTime),
            (self.queryManager.getStandHour, DataCellType.standHours),
            (self.queryManager.getStepCount, DataCellType.stepCount)
        ]
        
        for (query, dataType) in queries{
            query {data in
                
                print("Data: \(dataType): \(data)")
                
                let dataIndex = self.healthData.firstIndex(where: {$0.type == dataType}).orZero
                
                if [DataCellType.exerciseTime].contains(dataType){
                    self.healthData[dataIndex].data = "\(data.asString(style: .abbreviated))"
                }else{
                    self.healthData[dataIndex].data = "\(Int(data))"
                }
            }
        }
    }
    
}
