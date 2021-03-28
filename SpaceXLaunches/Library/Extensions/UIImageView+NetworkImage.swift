//
//  UIImageView+NetworkImage.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 27/03/21.
//

import UIKit
import SDWebImage

extension UIImageView {

    func loadImage(urlString: String?) {
        
        guard let urlString = urlString, let imageURL = URL(string: urlString) else {
            return
        }
        
        self.sd_setImage(with: imageURL, completed: nil)

    }
}
