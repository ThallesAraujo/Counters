//
//  BatteriesViewControllerLayout.swift
//  Counters
//
//  Created by Thalles Araújo on 14/03/23.
//

import Foundation
extension BatteriesViewController{
    
    override func viewWillLayoutSubviews() {
        self.mainList.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainList)
        mainList.fillParent()
    }
    
}
