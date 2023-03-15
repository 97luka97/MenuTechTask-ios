//
//  User.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

struct User: Decodable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let phoneNumber: String?
    let token: String?

    private enum CodingKeys: String, CodingKey {
        case data

        enum OuterCustomerAccountKeys: String, CodingKey {
            case customerAccount = "customer_account"
        }

        enum CustomerAccountKeys: String, CodingKey {
            case id,
                 firstName = "first_name",
                 lastName = "last_name",
                 email,
                 phoneNumber = "phone_number"
        }

        enum OuterTokenKeys: String, CodingKey {
            case token
        }

        enum TokenKeys: String, CodingKey {
            case value
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let outerTokenContainer = try container.nestedContainer(
            keyedBy: CodingKeys.OuterTokenKeys.self, forKey: .data
        )
        let tokenContainer = try outerTokenContainer.nestedContainer(
            keyedBy: CodingKeys.TokenKeys.self, forKey: .token
        )
        self.token = try tokenContainer.decodeIfPresent(String.self, forKey: .value)

        let outerCustomerAccountContainer = try container.nestedContainer(
            keyedBy: CodingKeys.OuterCustomerAccountKeys.self, forKey: .data
        )
        let customerAccountContainer = try outerCustomerAccountContainer.nestedContainer(
            keyedBy: CodingKeys.CustomerAccountKeys.self, forKey: .customerAccount
        )
        self.id = try customerAccountContainer.decodeIfPresent(Int.self, forKey: .id)
        self.firstName = try customerAccountContainer.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try customerAccountContainer.decodeIfPresent(String.self, forKey: .lastName)
        self.email = try customerAccountContainer.decodeIfPresent(String.self, forKey: .email)
        self.phoneNumber = try customerAccountContainer.decodeIfPresent(String.self, forKey: .phoneNumber)
    }
}
