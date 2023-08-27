//
//  DetailsViewOSTen.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 27/08/23.
//

import SwiftUI

@available(watchOS 10.0, *)
struct DetailsViewOSTen: View {
    
    var listSection: MainListSection
    var value: String
    
    var body: some View {
        VStack{
            Text("\(value) \(listSection.unit)").font(.title).foregroundStyle(Color(listSection.colorName))
        }.toolbar(content: {
            ToolbarItem {
                HStack{
                    Text(listSection.title).foregroundStyle(Color(listSection.colorName))
                    Spacer()
                    Image(listSection.iconName, bundle: .main).foregroundStyle(Color(listSection.colorName))
                }.padding()
            }
        }).containerBackground(Color(listSection.colorName).gradient, for: .tabView)
    }
}

#Preview {
    NavigationStack{
        if #available(watchOS 10.0, *) {
            DetailsViewOSTen(listSection: mainListSections[0], value: "200")
        } else {
            VStack{
                Text("Versão não suportada")
            }
        }
    }
}
