//
//  MapViewController.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 1/27/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    

    // MARK: - Properties
    var userLocationButton: MKUserTrackingButton!
    let manager = CLLocationManager()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTrackingButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserLocation()
    }
    
    // MARK: - IBActions
    @IBAction func searchButtonTapped(_ sender: Any) {
        
    }
    
    
    // MARK: - Helper Methods
    private func getUserLocation(){
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    private func layoutTrackingButton() {
        userLocationButton = MKUserTrackingButton(mapView: mapView)
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userLocationButton)
        
        NSLayoutConstraint.activate([
            userLocationButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            mapView.bottomAnchor.constraint(equalTo: userLocationButton.bottomAnchor, constant: 40)
            
        ])
    }
}

// MARK: - Extension/Delegate Methods
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.first{
            manager.stopUpdatingLocation()
        }
    }
}
