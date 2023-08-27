//
//  MainViewOSTen.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 27/08/23.
//

import SwiftUI

@available(watchOS 10.0, *)
struct MainViewOSTen: View {
    
    @StateObject var viewModel: HealthDataViewModel = .init()
    
    var body: some View {
        TabView {
            ForEach(mainListSections, id: \.title){ section in
                DetailsViewOSTen(listSection: section, value: getData(forItem: section))
            }
        }.toolbar{
            
            ToolbarItemGroup(placement: .bottomBar){
                NavigationLink(destination: CalendarView(), label: {
                    Image(systemName: "calendar")
                })
                
                NavigationLink(destination: BatteriesView(), label: {
                    Image(systemName: "bolt")
                })
            }
            
        }.tabViewStyle(.verticalPage).onAppear(perform: {
            viewModel.getHealthData()
        })
    }
    
    func getData(forItem item: MainListSection) -> String{
        return viewModel.healthData[item.dataType.rawValue].orEmpty
    }
}

#Preview {
    if #available(watchOS 10.0, *) {
        MainViewOSTen()
    } else {
        Text("Versão não compatível")
    }
}
