//
//  Stacks.swift
//  Counters
//
//  Created by Thalles Araújo on 12/03/23.
//

import Foundation
import UIKit

typealias StackedViews = [UIView]


class Stack: UIView{
    
    var stackedViews: [UIView] = []
    
    var mainView: UIStackView = .init()
    
    var axis: NSLayoutConstraint.Axis = .vertical
    
    var padding: Int = 8
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for view in stackedViews{
            mainView.addArrangedSubview(view)
        }
        
        mainView.axis = axis
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.alignment = .leading
        self.addSubview(mainView)
        mainView.fillParent(withPadding: padding)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

class VStack: Stack{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(padding: Int = 8, @Stacker _ viewClosure: () -> StackedViews){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 100))
        self.stackedViews = viewClosure()
        self.padding = padding
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


class HStack: Stack{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(padding: Int = 8, @Stacker _ viewClosure: () -> StackedViews){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        self.stackedViews = viewClosure()
        self.axis = .horizontal
        self.padding = padding
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

@resultBuilder public struct Stacker{
    
    public static func buildBlock(_ components: UIView...) -> [UIView] {
        return components
    }
    
}
