//
//  AppDelegate.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 28/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The application pivot class
    private lazy var appController = AppController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// Presenting the `AppController` main window
        let window = appController.window
        window.makeKeyAndVisible()

        return true
    }
}

