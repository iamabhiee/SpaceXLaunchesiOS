//
//  LaunchViewModel.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation
import UIKit.UIImage

struct LaunchViewModel {
    
    private let launch : Launch
    
    var number : String
    var title : String?
    var details : String?
    var upcomingImage : UIImage?
    var date : String?
    
    init(launch : Launch) {
        self.launch = launch
        
        let number = launch.flight_number ?? 0
        self.number = "#\(number)"
        self.title = launch.name
        self.details = launch.details
        
        if let date = launch.date_utc, let launchDate = Date.dateFromUTCServerDate(date: date) {
            self.date = launchDate.toLocalTimeString()
            
            if launchDate > Date() {
                self.upcomingImage = UIImage(named: "ic-upcoming")
            }
        }
    }
}
