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
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for City"
        searchController.hidesNavigationBarDuringPresentation = false
        present(searchController, animated: true, completion: nil)
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
            mapView.bottomAnchor.constraint(equalTo: userLocationButton.bottomAnchor, constant: 60)
            
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

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Creating Search Request
        guard let text = searchBar.text else { return }
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil{
                print("Error getting search data")
            } else {
                // Remove existing Annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                // Getting Data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                // Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                // Zoom in on annotation
                let coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}
