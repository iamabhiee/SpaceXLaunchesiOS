//
//  MImageCollectionViewCell.swift
//  dispatch
//
//  Created by Abhishek on 29/07/20.
//  Copyright © 2020 FS. All rights reserved.
//

import UIKit

class MImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWithImageUrl(_ imageUrl : String?) {
        imageView.loadImage(urlString: imageUrl)
    }
}
