//
//  MainViewControllerLayout.swift
//  Counters
//
//  Created by Thalles Araújo on 05/03/23.
//

import Foundation
import UIKit
extension MainViewController{
    
    override func viewWillLayoutSubviews() {
        self.mainList.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainList)
        mainList.fillParent(withPadding: 0)
    }
    
}
