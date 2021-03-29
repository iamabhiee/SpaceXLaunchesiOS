//
//  NSObject+Extension.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    class var classIdentifier: String {
        return String(format: "%@", self.nameOfClass)
    }
}
