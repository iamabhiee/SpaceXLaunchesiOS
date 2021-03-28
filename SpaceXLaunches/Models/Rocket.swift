//
//  Rocket.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import Foundation

struct Rocket {
    let name, description : String?
    let wikipedia: String?
    let flickr_images : [String]?
}

extension Rocket: Decodable {
    enum CodingKeys: CodingKey {
        case name
        case description
        case wikipedia
        case flickr_images
    }
}
