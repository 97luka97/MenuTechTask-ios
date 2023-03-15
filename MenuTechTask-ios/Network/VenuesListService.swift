//
//  VenuesListService.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

struct VenuesListBody: Encodable {
    let latitude: String
    let longitude: String
}

protocol VenuesListServiceProtocol {
    func getVenues(body: VenuesListBody) async throws -> [Venue]
}

final class VenuesListService: VenuesListServiceProtocol, NetworkService {

    // MARK: - Singleton

    static let shared: VenuesListService = VenuesListService()

    // MARK: - API

    func getVenues(body: VenuesListBody) async throws -> [Venue] {
        let encodedData = try? JSONEncoder().encode(body)
        let request = Request(body: encodedData)
        do {
            let data = try await makeRequest(request: request)
            let venuesList = try JSONDecoder().decode(VenuesList.self, from: data)
            return venuesList.venues ?? []
        } catch {
            throw error
        }
    }

    private struct Request: APIRequest {
        var method: HTTPMethod = .post
        var path: APIPath = .listOfVenues
        var body: Data?
    }
}
