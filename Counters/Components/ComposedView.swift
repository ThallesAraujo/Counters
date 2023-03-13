//
//  ComposedView.swift
//  Counters
//
//  Created by Thalles Araújo on 13/03/23.
//

import Foundation
import UIKit

class ComposedView: UIView{
    
    var body: UIView = .init()
    
    var padding: Int = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addSubview(body)
        body.fillParent(withPadding: padding)
    }
    
    init(padding: Int = 8, _ viewClosure: () -> UIView){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        self.body = viewClosure()
        self.padding = padding
    }
    
}
