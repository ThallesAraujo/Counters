//
//  Float+Extension.swift
//  Counters
//
//  Created by Thalles Araújo on 14/03/23.
//

import Foundation
extension Float{
    
    var percent: Int{
        let integerValue = Int(self * 100)
        
        if integerValue < 0{
            return integerValue * (-1)
        }
        
        return integerValue
    }
    
}
