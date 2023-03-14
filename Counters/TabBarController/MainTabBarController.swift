//
//  MainTabBarController.swift
//  Counters
//
//  Created by Thalles Araújo on 14/03/23.
//

import Foundation
import UIKit

struct Tab{
    var viewController: UIViewController
    var title: String
    var image: UIImage
}

class MainTabBarController: UITabBarController{
    
    let tabs: [Tab] = [
        .init(viewController: MainViewController(), title: "Saúde", image: UIImage(named: "tab.health").orEmpty),
        .init(viewController: BatteriesViewController(), title: "Baterias", image: UIImage(named: "tab.batteries").orEmpty)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UITabBar.appearance().barTintColor = .systemBackground
        //        tabBar.tintColor = .label
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = tabs.compactMap({createNavController(tab: $0)})
    }
    
    fileprivate func createNavController(tab: Tab) -> UIViewController {
        let navController = UINavigationController(rootViewController: tab.viewController)
        navController.tabBarItem.title = tab.title
        navController.tabBarItem.image = tab.image
        navController.navigationBar.prefersLargeTitles = true
        tab.viewController.navigationItem.title = tab.title
        return navController
    }
    
}
