//
//  NetworkError.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case invalidRequest
    case badData
    case badResponse
    case noNetwork
    case unauthorized
    case genericError

    init(statusCode: Int) {
        switch statusCode {
        case 401: self = .unauthorized
        case -1009: self = .noNetwork
        default: self = .genericError
        }
    }

    var message: String {
        switch self {
        case .noNetwork: return "No internet connection"
        case .unauthorized: return "Incorrect credentials"
        default: return "Unexpected error. Please try again"
        }
    }
}

extension Error {
    var customErrorString: String {
        (self as? NetworkError)?.message ?? localizedDescription
    }
}
