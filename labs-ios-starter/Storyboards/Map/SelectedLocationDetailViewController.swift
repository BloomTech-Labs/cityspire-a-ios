//
//  SelectedLocationDetailViewController.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/3/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit
import Lottie

class SelectedLocationDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var crimeLabel: UILabel!
    @IBOutlet weak var rentalLabel: UILabel!
    @IBOutlet weak var walkScoreLabel: UILabel!
    @IBOutlet weak var walkScoreAnimationView: UIView!
    @IBOutlet weak var rentalScoreAnimationView: UIView!
    
    // MARK: - Properties
    let locationController = LocationController.shared
    var locationID: Int?
    var locationName: String? {
        didSet {
            updateViews()
        }
    }
    let walkingAnimation = Animation.named("3999-walking")
    let rentalAnimation = Animation.named("46411-money-for-insurance")

    override func viewDidLoad() {
        super.viewDidLoad()
        runAnimations()
    }
    
    // MARK: - Private Methods
    private func updateViews() {
        guard let locationName = locationName else { return }
        locationController.getCityDetails(name: locationName) { (returnedLocation) in
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
                print("Error getting location data: \(error)")
            }
        }
    }

    private func runAnimations() {
        let animationViewWalking = AnimationView(animation: walkingAnimation)
        animationViewWalking.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        animationViewWalking.contentMode = .scaleAspectFit
        animationViewWalking.loopMode = .loop

        walkScoreAnimationView.addSubview(animationViewWalking)
        animationViewWalking.play()

        let animationViewRental = AnimationView(animation: rentalAnimation)
        animationViewRental.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        animationViewRental.contentMode = .scaleAspectFit
        animationViewRental.loopMode = .loop

        rentalScoreAnimationView.addSubview(animationViewRental)
        animationViewRental.play()
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
