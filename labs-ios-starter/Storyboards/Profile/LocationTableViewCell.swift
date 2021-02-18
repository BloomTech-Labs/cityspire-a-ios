//
//  LocationTableViewCell.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/17/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var locationNameLabel: UILabel!
    
    // MARK: - Properties
    var location: ReturnedLocation? {
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Helper Functions
    private func updateViews() {
        guard let location = location else { return }
        locationNameLabel.text = location.name
    }
}
