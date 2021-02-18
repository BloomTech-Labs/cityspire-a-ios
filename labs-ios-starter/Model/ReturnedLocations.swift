//
//  ReturnedLocations.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/17/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import Foundation

struct ReturnedLocation: Codable{
    var id: Int
    var name: String
    var cityID: String
    
    enum CodingKeys: String, CodingKey{
        case cityID = "city_id"
        case id, name
    }
}
