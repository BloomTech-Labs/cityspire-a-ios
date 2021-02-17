//
//  SelectedLocationDetailViewController.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/3/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit

class SelectedLocationDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var crimeLabel: UILabel!
    @IBOutlet weak var rentalLabel: UILabel!
    @IBOutlet weak var walkScoreLabel: UILabel!
    
    // MARK: - Properties
    let locationController = LocationController.shared
    var locationID: Int?
    var locationName: String? {
        didSet {
            locationController.getCityDetails(name: locationName!) { (returnedLocation) in
                do {
                    let result = try returnedLocation.get()
                    self.locationID = result.id
                    DispatchQueue.main.async {
                        self.nameLabel.text = self.locationName
                        self.populationLabel.text = "\(result.population)"
                        self.crimeLabel.text = "\(result.crimeRate)"
                        self.rentalLabel.text = "\(result.rentalRate)"
                        self.walkScoreLabel.text = "\(result.walkScore)"
                    }
                } catch {
                    print("Error getting Location Data:\(error)")
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func saveToFavoritesTapped(_ sender: UIButton) {
        guard let name = locationName else { return }
        guard let id = locationID else { return }
        let savedcity = SavedLocation(name: name, cityID: id)
        locationController.saveCityAsFavorite(location: savedcity) { (_) in
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "Location Saved", message: "\(name) has been added to favorites.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(ac, animated: true)
            }
        }
    }
    
}
