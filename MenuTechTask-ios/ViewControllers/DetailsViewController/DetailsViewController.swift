//
//  DetailsViewController.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

class DetailsViewController: UIViewController {

    private enum VenueCell: Int {
        case thumbnail = 0, details
    }

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(VenueThumbnailTableViewCell.self)
            tableView.register(VenueDetailsTableViewCell.self)
        }
    }

    // MARK: - Properties

    private let venue: Venue

    // MARK: - Init

    init(venue: Venue) {
        self.venue = venue
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @IBAction private func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func logoutButtonTapped(_ sender: UIButton) {
        UserManager.shared.clear()
        navigationController?.logout()
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 2 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venueCell = VenueCell(rawValue: indexPath.row)
        switch venueCell {
        case .thumbnail:
            let cell = tableView.dequeueReusableCell(VenueThumbnailTableViewCell.self, for: indexPath)
            if let thumbnail = venue.thumbnailMedium, let url = URL(string: thumbnail) { cell.loadImage(url: url) }
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(VenueDetailsTableViewCell.self, for: indexPath)
            cell.setup(venue: venue)
            return cell
        default: return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let venueCell = VenueCell(rawValue: indexPath.row)
        return venueCell == .thumbnail ? CGFloat(view.frame.height * 0.7) : UITableView.automaticDimension
    }
}
