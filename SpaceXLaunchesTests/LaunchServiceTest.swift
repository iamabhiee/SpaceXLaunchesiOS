//
//  LaunchServiceTest.swift
//  SpaceXLaunchesTests
//
//  Created by Abhishek on 29/03/21.
//

import XCTest
@testable import SpaceXLaunches

class LaunchServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchServiceFiiter() throws {
        let launchCurrentYear = Launch(name: "Test", date_utc: "2021-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: true, flight_number: 1)
        let launchLastYear = Launch(name: "Test", date_utc: "2020-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: true, flight_number: 2)
        let launchTwoYearAgo = Launch(name: "Test", date_utc: "2019-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: true, flight_number: 3)
        let launchThreeYearAgo = Launch(name: "Test", date_utc: "2018-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: true, flight_number: 4)
        let launchNextYear = Launch(name: "Test", date_utc: "2022-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: true, flight_number: 5)
        let unsuccessfulLaunch = Launch(name: "Test", date_utc: "2021-03-24T22:30:00.000Z", details: "Test details", rocket: "123", success: false, flight_number: 6)
        
        let service = LaunchService()
        let allData = [launchCurrentYear, launchLastYear, launchTwoYearAgo, launchThreeYearAgo, launchNextYear, unsuccessfulLaunch]
        let filteredData = service.applyFilter(launchList: allData)
        
        XCTAssertTrue(filteredData.contains(where: { $0.flight_number == 1 }))
        XCTAssertTrue(filteredData.contains(where: { $0.flight_number == 2 }))
        XCTAssertTrue(filteredData.contains(where: { $0.flight_number == 3 }))
        XCTAssertFalse(filteredData.contains(where: { $0.flight_number == 4 }))
        XCTAssertFalse(filteredData.contains(where: { $0.flight_number == 5 }))
        XCTAssertFalse(filteredData.contains(where: { $0.flight_number == 6 }))

    }

}
