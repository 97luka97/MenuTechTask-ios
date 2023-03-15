//
//  Venue.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 14.3.23..
//

import Foundation

struct VenuesList: Decodable {
    let venues: [Venue]?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    private enum VenuesKeys: String, CodingKey {
        case venues
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let venuesContainer = try container.nestedContainer(keyedBy: VenuesKeys.self, forKey: .data)
        self.venues = try venuesContainer.decodeIfPresent([Venue].self, forKey: .venues)
    }
}

struct Venue: Decodable {
    let name: String?
    let distance: Double?
    let description: String?
    let isOpen: Bool?
    let welcomeMessage: String?
    let thumbnailMedium: String?
    let address: String?
    let city: String?

    private enum CodingKeys: String, CodingKey {
        case venue, distance
    }

    private enum VenueKeys: String, CodingKey {
        case name, description, isOpen = "is_open", welcomeMessage = "welcome_message", address, city, image
    }

    private enum ImageKeys: String, CodingKey {
        case thumbnailMedium = "thumbnail_medium"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.distance = try container.decodeIfPresent(Double.self, forKey: .distance)

        let venueContainer = try container.nestedContainer(keyedBy: VenueKeys.self, forKey: .venue)
        self.name = try venueContainer.decodeIfPresent(String.self, forKey: .name)
        self.description = try venueContainer.decodeIfPresent(String.self, forKey: .description)
        self.isOpen = try venueContainer.decodeIfPresent(Bool.self, forKey: .isOpen)
        self.welcomeMessage = try venueContainer.decodeIfPresent(String.self, forKey: .welcomeMessage)
        self.address = try venueContainer.decodeIfPresent(String.self, forKey: .address)
        self.city = try venueContainer.decodeIfPresent(String.self, forKey: .city)

        let imageContainer = try venueContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        self.thumbnailMedium = try imageContainer.decodeIfPresent(String.self, forKey: .thumbnailMedium)
    }
}
