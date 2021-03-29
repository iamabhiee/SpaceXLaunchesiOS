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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureGlobalUI()
        
        let viewModel = LaunchListViewModel()
        let vc = LaunchesViewController.instantiate(viewModel: viewModel)
        let rootNVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootNVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func configureGlobalUI() {
        UINavigationBar.appearance().barTintColor = UIColor.init(named: "primaryColor")
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

