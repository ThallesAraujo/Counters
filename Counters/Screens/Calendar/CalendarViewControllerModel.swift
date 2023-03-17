//
//  CalendarViewControllerModel.swift
//  Counters
//
//  Created by Thalles Araújo on 17/03/23.
//

import Foundation

enum CalendarViewControllerDataType:String{
    case events = "Eventos"
    case reminders = "Lembretes"
}

struct CalendarViewControllerData{
    var dataType: CalendarViewControllerDataType
    var value: Int
}

