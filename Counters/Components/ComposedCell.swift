//
//  ComposedCell.swift
//  Counters
//
//  Created by Thalles Araújo on 13/03/23.
//

import Foundation
import UIKit

class ComposedCell: UITableViewCell{
    
    var body: () -> UIView = { return UIView() }
    var padding: Int = 8
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addSubview(body())
        body().fillParent(withPadding: padding)
    }
    
    init(padding: Int = 8, cellStyle: UITableViewCell.CellStyle = .default, identifier: String, _ viewClosure: @escaping () -> UIView){
        super.init(style: cellStyle, reuseIdentifier: identifier)
        self.body = viewClosure
        self.padding = padding
    }
    
}
