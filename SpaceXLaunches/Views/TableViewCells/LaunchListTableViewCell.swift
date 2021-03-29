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
    
    var item: LaunchViewModel! {
        didSet {
            setLaunchData()
        }
    }


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
    
    private func setLaunchData() {
        lblLaunchNumber.text = item.number
        lblLaunchName.text = item.title
        lblLaunchDetails.text = item.details
        lblLaunchDate.text = item.date
        upcomingLaunchImage.image = item.upcomingImage
    }
}
