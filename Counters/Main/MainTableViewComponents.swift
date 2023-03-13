//
//  MainTableViewComponents.swift
//  Counters
//
//  Created by Thalles Araújo on 07/03/23.
//

import Foundation

struct MainTableViewSection{
    var title: String
    var unit: String
    var dataType: DataCellType
    var iconName: String
    var colorName: String
}

let mainTableViewSections = [
    MainTableViewSection(title: "Calorias ",
                         unit: "Kcal",
                         dataType: .calories,
                         iconName: "figure.walk.circle",
                        colorName: "movementColor"),
    
    MainTableViewSection(title: "Tempo de Exercício",
                         unit: "",
                         dataType: .exerciseTime,
                         iconName: "clock",
                        colorName: "exerciseTimeColor"),
    
    MainTableViewSection(title: "Tempo em Pé ",
                         unit: "h",
                         dataType: .standHours,
                         iconName: "figure.stand",
                        colorName: "standHoursColor"),
    
    MainTableViewSection(title: "Passos ",
                         unit: "",
                         dataType: .stepCount,
                         iconName: "figure.walk",
                        colorName: "stepsColor")
]
