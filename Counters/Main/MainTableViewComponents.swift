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
}

let mainTableViewSections = [
    MainTableViewSection(title: "Calorias ", unit: "Kcal", dataType: .calories),
    MainTableViewSection(title: "Tempo de Exercício", unit: "", dataType: .exerciseTime),
    MainTableViewSection(title: "Tempo em Pé ", unit: "h", dataType: .standHours),
    MainTableViewSection(title: "Passos ", unit: "", dataType: .stepCount)
]
