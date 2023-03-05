//
//  AppDelegate.swift
//  Counters
//
//  Created by Thalles Araújo on 04/03/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigation = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }

    


}

