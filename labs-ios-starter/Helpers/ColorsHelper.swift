//
//  ColorsHelper.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/1/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit

class ColorsHelper {
    // MARK: TODO -
    // Add Colors here
    
    
}

// MARK: Extension
// Extension on UIColor in order to give easier color codes
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
