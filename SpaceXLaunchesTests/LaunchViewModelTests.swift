//
//  LaunchViewModelTests.swift
//  SpaceXLaunchesTests
//
//  Created by Abhishek on 29/03/21.
//

import XCTest
@testable import SpaceXLaunches

class LaunchViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchListViewModelWithPastDate() {
        let launch = Launch(name: "Test", date_utc: "2006-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: true, flight_number: 1)
        let launchVM = LaunchViewModel(launch: launch)
        
        XCTAssertEqual(launch.name, launchVM.title)
        XCTAssertEqual(launch.details, launchVM.details)
        XCTAssertEqual("#\(launch.flight_number!)", launchVM.number)
        
        if let date = launch.date_utc, let launchDate = Date.dateFromUTCServerDate(date: date)?.toLocalTimeString() {
            XCTAssertEqual(launchDate, launchVM.date)
        }
        
        XCTAssertNil(launchVM.upcomingImage)
    }
    
    func testLaunchListViewModelWithFutureDate() {
        let launch = Launch(name: "Test", date_utc: "2022-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: true, flight_number: 1)
        let launchVM = LaunchViewModel(launch: launch)
        
        XCTAssertEqual(launch.name, launchVM.title)
        XCTAssertEqual(launch.details, launchVM.details)
        XCTAssertEqual("#\(launch.flight_number!)", launchVM.number)
        
        if let date = launch.date_utc, let launchDate = Date.dateFromUTCServerDate(date: date)?.toLocalTimeString() {
            XCTAssertEqual(launchDate, launchVM.date)
        }
        
        XCTAssertNotNil(launchVM.upcomingImage)
        XCTAssertEqual(launchVM.upcomingImage, #imageLiteral(resourceName: "ic-upcoming"))
    }

}
