//
//  BatteriesView.swift
//  Counters for Watch Watch App
//
//  Created by Thalles Araújo on 23/03/23.
//

import Foundation
import SwiftUI

struct BatteriesView: View{
    
    var body: some View{
        VStack{
            Text("Nível de bateria:")
            Text("\(WKInterfaceDevice.current().batteryLevel.percent)%")
        }
    }
    
}
