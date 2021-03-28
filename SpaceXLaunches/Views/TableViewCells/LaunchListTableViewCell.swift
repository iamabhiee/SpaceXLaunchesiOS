//
//  LaunchListTableViewCell.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import UIKit

class LaunchListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblLaunchNumber : UILabel!
    @IBOutlet weak var lblLaunchName : UILabel!
    @IBOutlet weak var lblLaunchDetails : UILabel!
    @IBOutlet weak var lblLaunchDate : UILabel!
    @IBOutlet weak var upcomingLaunchImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with launch : Launch) {
        let number = launch.flight_number ?? 0
        lblLaunchNumber.text = "#\(number)"
        lblLaunchName.text = launch.name
        lblLaunchDetails.text = launch.details
        
        if let date = launch.date_utc, let launchDate = Date.dateFromUTCServerDate(date: date) {
            lblLaunchDate.text = launchDate.toLocalTimeString()
            
            if launchDate > Date() {
                upcomingLaunchImage.isHidden = false
            } else {
                upcomingLaunchImage.isHidden = true
            }
        }
        
    }
}
