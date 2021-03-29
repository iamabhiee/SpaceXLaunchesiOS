//
//  UITableView+Extension.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import UIKit

extension UITableView {
    func registerXibs(identifiers : [String]) {
        identifiers.forEach { (identifier) in
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
}

extension UICollectionView {
    func registerXibs(identifiers : [String]) {
        identifiers.forEach { (identifier) in
            self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
    }
}
