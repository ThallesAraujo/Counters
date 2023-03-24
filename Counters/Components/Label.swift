//
//  Label.swift
//  Counters
//
//  Created by Thalles Araújo on 13/03/23.
//

import Foundation
import UIKit

class Label: UILabel{
    
    init(_ text: String){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 20))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func textColor(_ color: UIColor) -> Label{
        self.textColor = color
        self.draw(self.frame)
        return self
    }
    
    func font(_ font: UIFont) -> Label{
        self.font = font
        self.draw(self.frame)
        return self
    }
    
}
