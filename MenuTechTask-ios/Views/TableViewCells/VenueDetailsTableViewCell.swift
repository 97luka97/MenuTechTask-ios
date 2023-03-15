//
//  VenueDetailsTableViewCell.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 14.3.23..
//

import UIKit

class VenueDetailsTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var welcomeMessageLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var venueTagView: VenueTagView!

    // MARK: - API

    func setup(venue: Venue) {
        nameLabel.text = venue.name
        welcomeMessageLabel.text = venue.welcomeMessage
        welcomeMessageLabel.isHidden = venue.welcomeMessage?.isEmpty ?? true
        descriptionLabel.text = venue.description
        let isOpen = venue.isOpen ?? false
        venueTagView.setup(isOn: isOpen, text: isOpen ? "CURRENTLY OPENED" : "CURRENTLY CLOSED")
    }
}

extension VenueDetailsTableViewCell: NibReusableCell {}
