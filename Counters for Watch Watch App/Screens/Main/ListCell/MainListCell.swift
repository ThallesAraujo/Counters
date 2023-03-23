//
//  MainListCell.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 21/03/23.
//

import Foundation
import SwiftUI

struct MainViewCell: View{
    
    var listSection: MainListSection
    var value: String
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(listSection.title).foregroundColor(Color(listSection.colorName))
                Text("\(value)\(listSection.unit)")
            }
            Spacer()
            Image(listSection.iconName).foregroundColor(Color(listSection.colorName))
        }
    }
    
}
