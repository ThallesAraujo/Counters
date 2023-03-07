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

//
//
//self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainList]|", metrics: nil, views: ["mainList" : mainList]))
//self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainList]|", metrics: nil, views: ["mainList" : mainList]))
//
//NSLayoutConstraint.activate([
//          self.pokemonListingTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//          self.pokemonListingTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//          self.pokemonListingTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//          self.pokemonListingTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
//      ])

extension UIView{
    
    func fillParent(){
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[thisView]|", metrics: nil, views: ["thisView" : self]))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[thisView]|", metrics: nil, views: ["thisView" : self]))
    }
    
    func fillParent(withPadding padding: Int){
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[thisView]-\(padding)-|", metrics: nil, views: ["thisView" : self]))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding)-[thisView]-\(padding)-|", metrics: nil, views: ["thisView" : self]))
    }
    
    func stacked(axis: NSLayoutConstraint.Axis, _ views: UIView...) -> UIView{
        
        let stack = UIStackView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 100))
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.alignment = .leading
        
        for view in views{
            stack.addArrangedSubview(view)
            //view.fillParent()
        }
        
        stack.fillParent(withPadding: 8)
        
        return stack
    }
    
}
