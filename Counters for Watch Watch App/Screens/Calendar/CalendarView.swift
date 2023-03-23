//
//  CalendarView.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 23/03/23.
//

import Foundation
import SwiftUI

struct CalendarView: View{
    
    @StateObject var viewModel = CalendarViewModel()
    
    var body: some View{
        List{
            VStack(alignment: .leading){
                Text("Eventos:")
                Text(viewModel.calendarData.events)
            }
            VStack(alignment: .leading){
                Text("Lembretes:")
                Text(viewModel.calendarData.reminders)
            }
        }.onAppear(perform: {
            viewModel.fetchData()
        })
    }
    
}
