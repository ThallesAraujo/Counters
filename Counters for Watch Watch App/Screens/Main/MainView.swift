//
//  ContentView.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 17/03/23.
//

import SwiftUI
struct MainView: View {
    
    @State var viewModel: HealthDataViewModel = .init()
    
    var body: some View {
        List{
            ForEach(mainListSections, id: \.dataType){ item in
                MainViewCell(listSection: item, value: getData(forItem: item))
            }
        }
        .onAppear(perform: {
            viewModel.getHealthData()
        })
    }
    
    func getData(forItem item: MainListSection) -> String{
        return viewModel.healthData[item.dataType.rawValue].orEmpty
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

