//
//  AppCoordinator.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 29/03/21.
//

import UIKit

protocol AppCoordinatorProtocol : class {
    func start()
    func redirectToDetails(for rocketId : String)
    func openExternalURL(url : String?)
}

class AppCoordinator {
    let window : UIWindow?
    var rootNavigationController : UINavigationController?
    
    init(with window : UIWindow?) {
        self.window = window
    }
}

extension AppCoordinator : AppCoordinatorProtocol {
    func start() {
        let launchService = LaunchService()
        let viewModel = LaunchListViewModel(service: launchService, coordinator: self)
        let vc = LaunchesViewController.instantiate(viewModel: viewModel)
        rootNavigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
    
    func redirectToDetails(for rocketId : String) {
        let rocketViewModel = RocketDetailsViewModel(rocketId: rocketId, coordinator: self)
        let rocketsViewController = RocketsViewController.instantiate(viewModel: rocketViewModel)
        self.rootNavigationController?.pushViewController(rocketsViewController, animated: true)
    }
    
    func openExternalURL(url: String?) {
        self.rootNavigationController?.visibleViewController?.openInSafari(url: url)
    }
}
