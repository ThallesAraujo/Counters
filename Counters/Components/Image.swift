//
//  Image.swift
//  Counters
//
//  Created by Thalles Araújo on 23/03/23.
//

import Foundation
import UIKit
class Image: UIImageView{
    
    init(name: String) {
        super.init(image: UIImage.init(named: name))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func tintColor(_ color: UIColor) -> Image{
        self.tintColor = color
        self.draw(self.frame)
        return self
    }
}
