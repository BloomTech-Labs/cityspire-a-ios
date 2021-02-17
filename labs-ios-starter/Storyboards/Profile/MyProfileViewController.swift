//
//  MyProfileViewController.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/2/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var favoritePlacesLabel: UILabel!

    // MARK: - Properties
    var profileController: ProfileController = ProfileController.shared
    let locationController = LocationController.shared
    var mySavedLocations: [ReturnedLocation] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setTextFieldAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationController.getAllSavedFavoriteCities { (result) in
            do{
                let returnedLocations = try result.get()
                self.mySavedLocations = returnedLocations
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error getting back saved location data: \(error)")
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: - Private
    private func setTextFieldAttributes() {
        nameTextField.layer.cornerRadius = 18
        nameTextField.layer.shadowOpacity = 0.3
        nameTextField.layer.shadowRadius = 2.0
        nameTextField.layer.shadowColor = UIColor.darkGray.cgColor
        nameTextField.layer.shadowOffset = CGSize(width: 8, height: 8)
        nameTextField.text = profileController.authenticatedUserProfile?.name

        emailtextField.layer.cornerRadius = 18
        emailtextField.layer.shadowOpacity = 0.3
        emailtextField.layer.shadowRadius = 2.0
        emailtextField.layer.shadowColor = UIColor.darkGray.cgColor
        emailtextField.layer.shadowOffset = CGSize(width: 8, height: 8)
        emailtextField.text = profileController.authenticatedUserProfile?.email

        favoritePlacesLabel.layer.cornerRadius = 18
        favoritePlacesLabel.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.4)

        avatarImageView.image = profileController.authenticatedUserProfile?.avatarImage
    }
}

// MARK: - Extensions
extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySavedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as? LocationTableViewCell else { return UITableViewCell()}
        cell.location = mySavedLocations[indexPath.row]
        return cell
    }
}
