//
//  UIView+Extension.swift
//  Counters
//
//  Created by Thalles Araújo on 05/03/23.
//

// Guia para a VFL
//https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html

import Foundation
import UIKit


extension UIView{
    
    func fillParent(withPadding padding: Int = 8){
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[thisView]-\(padding)-|", metrics: nil, views: ["thisView" : self]))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding)-[thisView]-\(padding)-|", metrics: nil, views: ["thisView" : self]))
    }
    
    func horizontalPadding(_ padding: Int = 8){
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[thisView]-\(padding)-|", metrics: nil, views: ["thisView" : self]))
    }
    
    func verticalPadding(_ padding: Int = 8){
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding)-[thisView]-\(padding)-|", metrics: nil, views: ["thisView" : self]))
    }
    
    func vStack(_ views: UIView...) -> UIView{
        return stacked(axis: .vertical, views)
    }
    
    func hStack(_ views: UIView...) -> UIView{
        return stacked(axis: .horizontal, views)
    }
    
    private func stacked(axis: NSLayoutConstraint.Axis, _ views: [UIView]) -> UIView{
        
        let stack = UIStackView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 100))
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.alignment = .leading
        
        for view in views{
            stack.addArrangedSubview(view)
        }
        
        stack.fillParent()
        
        return stack
    }
    
}
