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
    
    var view: UIView = .init()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(view)
        view.fillParent(withPadding: 16)
        self.layoutIfNeeded()
        
    }
    
}
