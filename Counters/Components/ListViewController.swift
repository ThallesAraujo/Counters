//
//  ListViewController.swift
//  Counters
//
//  Created by Thalles Araújo on 17/03/23.
//

import Foundation
import UIKit

class ListViewController: UIViewController{
    
    var mainList: UITableView = .init()
    
    func setupListiOS13(){
        if #available(iOS 13.0, *) {
            self.mainList = .init(frame: CGRect.zero, style: .insetGrouped)
        }
    }
    
    
    
}

extension ListViewController{
    override func viewWillLayoutSubviews() {
        self.mainList.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainList)
        mainList.fillParent(withPadding: 0)
    }
}


