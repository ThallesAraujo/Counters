//
//  Counters_for_WatchApp.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 17/03/23.
//

import SwiftUI

@main
struct Counters_for_Watch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(watchOS 10, *){
                NavigationStack{
                    MainViewOSTen()
                }
            }else{
                TabView{
                    MainView()
                    BatteriesView()
                    CalendarView()
                }.tabViewStyle(.page)
            }
        }
    }
}
