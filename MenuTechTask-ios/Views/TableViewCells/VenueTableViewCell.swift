//
//  VenueTableViewCell.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var workingHoursLabel: UILabel!
    @IBOutlet private weak var venueTagView: VenueTagView!

    // MARK: - API

    func setup(venue: Venue) {
        nameLabel.text = venue.name
        distanceLabel.text = "\(Int(venue.distance ?? 0.0)) m"
        addressLabel.text = "\(venue.address ?? ""), \(venue.city ?? "")"
        workingHoursLabel.text = venue.isOpen ?? false ? "Opened" : "Closed"
        venueTagView.isHidden = true
        updateAppearance(opened: venue.isOpen ?? false)
    }

    // MARK: - Helpers

    private func updateAppearance(opened: Bool) {
        nameLabel.textColor = opened ? CustomColor.black100.uiColor : CustomColor.black40.uiColor
        distanceLabel.textColor = opened ? CustomColor.black100.uiColor : CustomColor.black40.uiColor
        addressLabel.textColor = opened ? CustomColor.black60.uiColor : CustomColor.black40.uiColor
        workingHoursLabel.textColor = opened ? CustomColor.black60.uiColor : CustomColor.black40.uiColor
    }
}

extension VenueTableViewCell: NibReusableCell { }
