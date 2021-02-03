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
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

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
        cell.textLabel?.text = "Location"
        return cell
    }
}
