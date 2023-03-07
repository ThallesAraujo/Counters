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
    
}
