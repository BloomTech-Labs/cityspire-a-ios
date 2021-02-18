//
//  LocationTableViewCell.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/17/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var walkScoreDisplay: UILabel!
    @IBOutlet weak var crimeRateDisplay: UILabel!
    @IBOutlet weak var rentalRateDisplay: UILabel!

    // MARK: - Properties
    let locationController = LocationController.shared

    var location: ReturnedLocation? {
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Helper Functions
    private func updateViews() {
        guard let location = location else { return }
        locationNameLabel.text = location.name
        locationController.getCityDetails(name: location.name) { (returnedLocation) in
            do {
                let result = try returnedLocation.get()
                DispatchQueue.main.async {
                    switch result.walkScore {
                    case 0...35:
                        self.walkScoreDisplay.text = "🚶‍♂️"
                    case 36...70:
                        self.walkScoreDisplay.text = "🚶🏽‍♀️🚶🏼"
                    case 71...100:
                        self.walkScoreDisplay.text = "🚶🏽‍♀️🚶🏼🚶‍♂️"
                    default:
                        self.walkScoreDisplay.text = "\(result.walkScore)"
                    }

                    switch result.crimeRate {
                    case 0...35:
                        self.crimeRateDisplay.text = "🦹🏼‍♂️"
                    case 36...70:
                        self.crimeRateDisplay.text = "🦹🏼‍♂️🦹🏼‍♂️"
                    case 71...100:
                        self.crimeRateDisplay.text = "🦹🏼‍♂️🦹🏼‍♂️🦹🏼‍♂️"
                    default:
                        self.crimeRateDisplay.text = "\(result.crimeRate)"
                    }

                    switch result.rentalRate {
                    case 0...1000:
                        self.rentalRateDisplay.text = "$"
                    case 1001...1500:
                        self.rentalRateDisplay.text = "$$"
                    case 1501...10000:
                        self.rentalRateDisplay.text = "$$$"
                    default:
                        self.rentalRateDisplay.text = "\(result.rentalRate)"
                    }
                }
            } catch {
                print("Error getting location data: \(error)")
            }
        }
    }
}
