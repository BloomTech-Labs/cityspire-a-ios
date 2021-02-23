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
    @IBOutlet weak var profileButton: UIButton!
    

    // MARK: - Properties
    var userLocationButton: MKUserTrackingButton!
    let manager = CLLocationManager()
    var locationName: String?
    let locationController = LocationController.shared

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTrackingButton()
        mapView.delegate = self
        layoutProfileButton()
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
    
    private func layoutProfileButton(){
        profileButton.layer.cornerRadius = 25
        profileButton.layer.shadowOffset = CGSize(width: -5, height: 5)
        profileButton.layer.shadowOpacity = 0.6
        profileButton.layer.shadowRadius = 5
        profileButton.layer.shadowColor = UIColor.black.cgColor
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationDetailSegue" {
            let detailVC = segue.destination as! SelectedLocationDetailViewController
            detailVC.locationName = self.locationName
        }
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let ac = UIAlertController(title: locationName!, message: "What would you like to do?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Details", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "LocationDetailSegue", sender: nil)
        }))
        ac.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        present(ac, animated: true)
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.locationName = text
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil{
                print("Error getting search data")
            } else {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                let coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}
