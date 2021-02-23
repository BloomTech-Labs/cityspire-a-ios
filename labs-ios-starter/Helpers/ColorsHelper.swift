//
//  ColorsHelper.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/1/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit

class ColorsHelper {
    static let harvestGold = UIColor(red: 223, green: 151, blue: 53)
    static let brownSugar = UIColor(red: 167, green: 111, blue: 70)
    static let sonicSilver = UIColor(red: 117, green: 123, blue: 127)
    static let lightFrenchBeige = UIColor(red: 210, green: 181, blue: 115)
    static let nonPhotoBlue = UIColor(red: 164, green: 225, blue: 243)
}

// MARK: Extension
extension UIColor {
    
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
