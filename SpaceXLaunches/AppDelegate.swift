//
//  AppDelegate.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCordinator : AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureGlobalUI()
        
        appCordinator = AppCoordinator(with: window)
        appCordinator.start()
        
        return true
    }
    
    func configureGlobalUI() {
        UINavigationBar.appearance().barTintColor = UIColor.init(named: "primaryColor")
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

