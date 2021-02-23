//
//  ReturnedLocations.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/17/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import Foundation
import MapKit

struct ReturnedLocation: Codable{
    var id: Int
    var name: String
    var cityID: String
    var lattitude: CLLocationCoordinate2D?
    var longitude: CLLocationCoordinate2D?
    
    enum CodingKeys: String, CodingKey{
        case cityID = "city_id"
        case id, name
    }
}
