//
//  NetworkService.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

protocol NetworkService {
    @discardableResult
    func makeRequest(request: APIRequest) async throws -> Data
}

extension NetworkService {

    @discardableResult
    func makeRequest(request: APIRequest) async throws -> Data {
        guard Reachability.isConnectedToNetwork() else {
            throw NetworkError.noNetwork
        }
        guard let myRequest = try? await request.urlRequest() else {
            throw NetworkError.invalidRequest
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: myRequest)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.isResponseOK() else { throw NetworkError(statusCode: response.statusCode) }
            return data
        } catch {
            throw error
        }
    }
}
