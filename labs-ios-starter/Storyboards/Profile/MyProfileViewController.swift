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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setTextFieldAttributes()
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
        // MARK: TODO
        // Update this with correct number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") else { return UITableViewCell()}
        // Test Cell
        // MARK: TODO
        // Create swift file for table view cell
        cell.textLabel?.text = "Location"
        cell.detailTextLabel?.text = "Number of places for rent?"
        return cell
    }
}
