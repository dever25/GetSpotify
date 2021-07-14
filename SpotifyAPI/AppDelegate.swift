//
//  AppDelegate.swift
//  SpotifyAPI
//
//  Created by Дмитрий Рудаков on 14.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let viewModel = LogInViewModel()
        loginViewController.viewModel = viewModel
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

