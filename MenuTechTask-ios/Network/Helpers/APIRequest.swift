//
//  APIRequest.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol APIRequest {
    var method: HTTPMethod { get }
    var path: APIPath { get }
    var body: Data? { get }
}

extension APIRequest {
    var body: Data? { nil }

    func urlRequest() async throws -> URLRequest {
        var urlComponents = URLComponents(string: Constants.baseURL)
        urlComponents?.path = path.path
        guard let url = urlComponents?.url else { throw NetworkError.badUrl }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = [
            "application": "mobile-application",
            "Content-Type": "application/json",
            "Api-Version": "3.7.0",
            "Device-UUID": Constants.deviceID
        ]
        urlRequest.httpBody = body
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
