//
//  Launch.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import Foundation

struct Launch {
    let name: String?
    let date_utc: String?
    let details, rocket: String?
    let success: Bool?
    let flight_number : Int?
}

extension Launch: Decodable {
    enum CodingKeys: CodingKey {
        case name
        case date_utc
        case success
        case details
        case flight_number
        case rocket
    }
}
