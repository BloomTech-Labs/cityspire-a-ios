//
//  Location.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/16/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import Foundation

struct Location: Codable{
    var id: Int
    var population: Int
    var crimeRate: Double
    var rentalRate: Double
    var walkScore: Int
    var city: String
    var state: String
    
    enum CodingKeys: String, CodingKey{
        case id = "id_num"
        case crimeRate = "crime_rate"
        case rentalRate = "rental_rate"
        case walkScore = "walk_score"
        case city, state, population
    }
}
