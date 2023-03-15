//
//  APIPath.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

enum APIPath: String {
    case login, listOfVenues

    var path: String {
        switch self {
        case .login: return "/api/customers/login"
        case .listOfVenues: return "/api/directory/search"
        }
    }
}
