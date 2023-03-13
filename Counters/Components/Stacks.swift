//
//  Stacks.swift
//  Counters
//
//  Created by Thalles Araújo on 12/03/23.
//

import Foundation
import UIKit

class Stack: UIView{
    
    var stackedViews: [UIView] = []
    
    var mainView: UIStackView = .init()
    
    var axis: NSLayoutConstraint.Axis = .vertical
    
    var padding: Int = 8
    
    var horizontalPadding: Int = 0
    
    var verticalPadding: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for view in stackedViews{
            mainView.addArrangedSubview(view)
        }
        
        mainView.axis = axis
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.alignment = .leading
        self.addSubview(mainView)
        if self.horizontalPadding > 0{
            mainView.horizontalPadding(horizontalPadding)
        }else if verticalPadding > 0{
            mainView.verticalPadding(verticalPadding)
        }else{
            mainView.fillParent(withPadding: padding)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

class VStack: Stack{
    
    init(padding: Int = 8, @ViewComposed _ viewClosure: () -> [UIView]){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 100))
        self.stackedViews = viewClosure()
        self.padding = padding
    }
    
    init(verticalPadding: Int, @ViewComposed _ viewClosure: () -> [UIView]){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        self.stackedViews = viewClosure()
        self.axis = .horizontal
        self.verticalPadding = padding
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


class HStack: Stack{
    
    init(padding: Int = 8, @ViewComposed _ viewClosure: () -> [UIView]){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        self.stackedViews = viewClosure()
        self.axis = .horizontal
        self.padding = padding
    }
    
    init(horizontalPadding: Int, @ViewComposed _ viewClosure: () -> [UIView]){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        self.stackedViews = viewClosure()
        self.axis = .horizontal
        self.horizontalPadding = padding
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

@resultBuilder public struct ViewComposed{
    
    public static func buildBlock(_ components: UIView...) -> [UIView] {
        return components
    }
    
}
