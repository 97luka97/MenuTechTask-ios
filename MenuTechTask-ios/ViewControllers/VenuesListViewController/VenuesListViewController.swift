//
//  VenuesListViewController.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

class VenuesListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(VenueTableViewCell.self)
        }
    }

    // MARK: - Properties

    private let viewModel: VenuesListViewModel

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getVenues()
    }

    // MARK: - Init

    init(viewModel: VenuesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func getVenues() {
        Task {
            showSpinner()
            let body = VenuesListBody(latitude: "44.001783", longitude: "21.26907")
            try await viewModel.getVenues(body: body)
            tableView.reloadData()
            hideSpinner()
        }
    }
}

// MARK: - UITableViewDataSource

extension VenuesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.venues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(VenueTableViewCell.self, for: indexPath)
        cell.setup(venue: viewModel.venues[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension VenuesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController(venue: viewModel.venues[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 125 }
}
