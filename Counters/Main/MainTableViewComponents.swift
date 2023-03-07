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
}

let mainTableViewSections = [
    MainTableViewSection(title: "Calorias: ", unit: "Kcal"),
    MainTableViewSection(title: "Tempo de Exercício", unit: "h"),
    MainTableViewSection(title: "Tempo em Pé: ", unit: "h"),
    MainTableViewSection(title: "Passos: ", unit: "")
]
