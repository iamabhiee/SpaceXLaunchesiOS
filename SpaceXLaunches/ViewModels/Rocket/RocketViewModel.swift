//
//  RocketViewModel.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation

struct RocketViewModel {
    var name : String?
    var details : String?
    var url : String?
    var images : [String] = []
    
    init(with rocket : Rocket) {
        self.name = rocket.name
        self.details = rocket.description
        self.url = rocket.wikipedia
        self.images = rocket.flickr_images ?? []
    }
}
