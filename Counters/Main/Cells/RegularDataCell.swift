//
//  RegularDataCell.swift
//  Counters
//
//  Created by Thalles Araújo on 07/03/23.
//

import Foundation
import UIKit

let regularCellDataIdentifier = "regularCellData"

enum DataCellType: String{
    
    case calories = "calories"
    case standHours = "standHours"
    case exerciseTime = "exerciseTime"
    case stepCount = "stepCount"
    
}

class RegularDataCell: UITableViewCell{
    
    override var reuseIdentifier: String { return regularCellDataIdentifier }
    
    var title: UILabel = .init()
    var data: UILabel = .init()
    
    var icon: UIImageView = .init()
    
    var dataColor: UIColor = .init(named: "defaultDataColor").orDefault
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let stack = VStack(padding: 0){
            HStack(padding: 0){
                icon
                HStack(horizontalPadding: 4){
                    title
                }
            }
            data
        }
        
        addSubview(stack)
        stack.fillParent(withPadding: 16)
        
        self.title.textColor = dataColor
        self.icon.tintColor = dataColor
        
        self.layoutIfNeeded()
        
        
    }
    
}
