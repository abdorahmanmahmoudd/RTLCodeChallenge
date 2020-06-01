//
//  AppController.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 28/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import UIKit

final class AppController {
    
    /// The application main window
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    /// Network requests
    let api = API()
    
    init() {

        /// Go to news screen
        routeToNews()
    }
    
    /// Set window root to News view controller
    private func routeToNews() {
        
        /// initialize news view model with the API object
        let newsViewModel = NewsViewModel(api: api)
        
        /// Inject the view model into the news view controller
        let newsViewController = NewsViewController.create(payload: newsViewModel)
        
        let navigationController = UINavigationController(rootViewController: newsViewController)
        navigationController.navigationBar.isTranslucent = false
        
        window.rootViewController = navigationController
    }
}
