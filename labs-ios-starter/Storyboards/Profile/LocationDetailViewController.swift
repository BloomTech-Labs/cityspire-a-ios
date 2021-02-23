//
//  LocationDetailViewController.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/2/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Lottie

class LocationDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var crimeLabel: UILabel!
    @IBOutlet weak var rentalLabel: UILabel!
    @IBOutlet weak var walkScoreLabel: UILabel!
    @IBOutlet weak var detailMapView: MKMapView!
    @IBOutlet weak var walkingAnimationView: UIView!

    // MARK: - Properties
    let locationController = LocationController.shared
    var locationName: String? {
        didSet{
            updateViews()
        }
    }
    let walkingAnimation = Animation.named("39992-walking")

    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = AnimationView(animation: walkingAnimation)
        animationView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        walkingAnimationView.addSubview(animationView)
        animationView.play()
        zoomToLocation(locationName: locationName!)
    }
    // MARK: - Private Methods
    private func updateViews() {
        guard let locationName = locationName else { return }
        title = locationName
        locationController.getCityDetails(name: locationName) { (returnedLocation) in
            do {
                let result = try returnedLocation.get()
                DispatchQueue.main.async {
                    self.populationLabel.text = "\(result.population.formattedWithSeparator) humans"
                    self.crimeLabel.text = "\(result.crimeRate)%"
                    self.rentalLabel.text = "\(result.rentalRate)"
                    self.walkScoreLabel.text = "\(result.walkScore)"
                }
            } catch {
                print("Error getting location data: \(error)")
            }
        }
    }
    
    private func zoomToLocation(locationName: String) {
       
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationName
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil{
                print("Error getting search data")
            } else {
                let annotations = self.detailMapView.annotations
                self.detailMapView.removeAnnotations(annotations)
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = locationName
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.detailMapView.addAnnotation(annotation)
                
                let coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.detailMapView.setRegion(region, animated: true)
            }
        }

    }
}

// MARK: - Extensions
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
