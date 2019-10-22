//
//  SceneDelegate.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let bestSellerVC = BestSellersVC()
        let favVC = FavoritesVC()
        let settingsVC = SettingsViewController()
        let navVC = UINavigationController(rootViewController: bestSellerVC)
        let tabController = UITabBarController()
        let bestTab = UITabBarItem(title: "Best Sellers", image: UIImage(named: "best-seller"), tag: 0)
        let settingsTab = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 2)
            //UITabBarItem(tabBarSystemItem: .more, tag: 2)
        let favTab = UITabBarItem(title: "Favorites", image: UIImage(named: "bookmark-ribbon"), tag: 1)
            //UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        navVC.tabBarItem = bestTab
        favVC.tabBarItem = favTab
        settingsVC.tabBarItem = settingsTab
        tabController.viewControllers = [navVC,favVC,settingsVC]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

