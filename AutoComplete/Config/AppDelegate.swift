//
//  AppDelegate.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?
    internal var coordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navController = NavigationController()
        // Send that into our coordinator so that it can display view controllers
        coordinator = RootCoordinator(navigationController: navController)
        // Tell the coordinator to take over control
        coordinator?.start()
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}
