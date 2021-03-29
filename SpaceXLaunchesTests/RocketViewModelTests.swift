//
//  RocketViewModelTests.swift
//  SpaceXLaunchesTests
//
//  Created by Abhishek on 29/03/21.
//

import XCTest
@testable import SpaceXLaunches

class RocketViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRocketViewModel() {
        let rocket = Rocket(name: "Test Rocket", description: "Test Desc", wikipedia: "wikipedia", flickr_images: ["https://imgur.com/DaCfMsj.jpg","https://imgur.com/azYafd8.jpg"])
        let rocketVM = RocketViewModel(with: rocket)
        
        XCTAssertEqual(rocket.name, rocketVM.name)
        XCTAssertEqual(rocket.description, rocketVM.details)
        XCTAssertEqual(rocket.wikipedia, rocketVM.url)
        XCTAssertEqual(rocket.flickr_images, rocketVM.images)
    }

}
