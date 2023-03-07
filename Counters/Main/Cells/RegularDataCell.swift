//
//  RegularDataCell.swift
//  Counters
//
//  Created by Thalles Araújo on 07/03/23.
//

import Foundation
import UIKit

let regularCellDataIdentifier = "regularCellData"

class RegularDataCell: UITableViewCell{
    
    override var reuseIdentifier: String { return regularCellDataIdentifier }
    
    var title: UILabel = .init()
    var data: UILabel = .init()
    
    var icon: UIImageView = .init()
    
    var dataColor: UIColor = .init(named: "defaultDataColor") ?? .systemBlue
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let stack = stacked(axis: .vertical,
                            stacked(axis: .horizontal, icon, title),
                            stacked(axis: .horizontal, data)
        )
        addSubview(stack)
        stack.fillParent(withPadding: 8)
        
        self.title.textColor = dataColor
        self.icon.tintColor = dataColor
        
        
    }
    
}
