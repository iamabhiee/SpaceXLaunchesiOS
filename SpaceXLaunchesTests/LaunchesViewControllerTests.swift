//
//  LaunchesViewControllerTests.swift
//  SpaceXLaunchesTests
//
//  Created by Abhishek on 29/03/21.
//

import XCTest
@testable import SpaceXLaunches

class LaunchesViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchesViewControllerInit() {
        let launchService = LaunchService()
        let viewModel = LaunchListViewModel(service: launchService, coordinator: nil)
        let vc = LaunchesViewController.instantiate(viewModel: viewModel)
        
        XCTAssertNotNil(vc)
    }

    func testDetailsViewControllerInit() {
        let rocketId = "1"
        let rocketViewModel = RocketDetailsViewModel(rocketId: rocketId)
        let rocketsViewController = RocketsViewController.instantiate(viewModel: rocketViewModel)
        
        XCTAssertNotNil(rocketsViewController)
        XCTAssertEqual(rocketId, rocketViewModel.rocketId)
    }
}
