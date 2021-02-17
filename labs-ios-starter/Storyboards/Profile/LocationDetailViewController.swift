//
//  LocationDetailViewController.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/2/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var crimeLabel: UILabel!
    @IBOutlet weak var rentalLabel: UILabel!
    @IBOutlet weak var walkScoreLabel: UILabel!
    
    // MARK: - Properties
    let locationController = LocationController.shared
    var locationName: String? {
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Private Methods
    private func updateViews() {
        guard let locationName = locationName else { return }
        locationController.getCityDetails(name: locationName) { (returnedLocation) in
            do {
                let result = try returnedLocation.get()
                DispatchQueue.main.async {
                    self.locationNameLabel.text = self.locationName
                    self.populationLabel.text = "\(result.population)"
                    self.crimeLabel.text = "\(result.crimeRate)"
                    self.rentalLabel.text = "\(result.rentalRate)"
                    self.walkScoreLabel.text = "\(result.walkScore)"
                }
            } catch {
                print("Error getting location data: \(error)")
            }
        }
    }
}


