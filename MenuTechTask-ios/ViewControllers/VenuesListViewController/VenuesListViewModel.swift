//
//  VenuesListViewModel.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

final class VenuesListViewModel {

    // MARK: - Properties

    private var venuesListService: VenuesListServiceProtocol!
    private(set) var venues = [Venue]()

    // MARK: - Init

    init(venuesListService: VenuesListServiceProtocol = VenuesListService.shared) {
        self.venuesListService = venuesListService
    }

    // MARK: - API

    func getVenues(body: VenuesListBody) async throws {
        do {
            self.venues = try await venuesListService.getVenues(body: body)
        } catch {
            throw error
        }
    }
}
