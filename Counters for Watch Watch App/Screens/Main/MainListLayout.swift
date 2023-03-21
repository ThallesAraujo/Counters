//
//  MainListLayout.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 21/03/23.
//

import Foundation
struct MainListSection{
    var title: String
    var unit: String
    var dataType: DataType
    var iconName: String
    var colorName: String
}

let mainListSections = [
    MainListSection(title: "Calorias",
                         unit: "Kcal",
                         dataType: .calories,
                         iconName: "calories.icon",
                        colorName: "movementColor"),
    
    MainListSection(title: "Tempo de Exercício",
                         unit: "",
                         dataType: .exerciseTime,
                         iconName: "exercise.time.icon",
                        colorName: "exerciseTimeColor"),
    
    MainListSection(title: "Tempo em Pé",
                         unit: "h",
                         dataType: .standHours,
                         iconName: "stand.hour.icon",
                        colorName: "standHoursColor"),
    
    MainListSection(title: "Passos",
                         unit: "",
                         dataType: .stepCount,
                         iconName: "step.count.icon",
                        colorName: "stepsColor")
]
