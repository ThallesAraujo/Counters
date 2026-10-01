//
//  SceneDelegate.swift
//  Counters
//
//  Created by Thalles Araújo on 30/09/26.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }


        window = UIWindow(windowScene: windowScene)
        
        let home = MainTabBarController()
        window?.rootViewController = home
        window?.makeKeyAndVisible()
    }
}
