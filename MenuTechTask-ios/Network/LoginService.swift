//
//  LoginService.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

struct LoginBody: Encodable {
    let email: String
    let password: String
}

protocol LoginServiceProtocol {
    func loginUser(body: LoginBody) async throws
}

final class LoginService: LoginServiceProtocol, NetworkService {

    // MARK: - Singleton

    static let shared: LoginService = LoginService()

    private init(userManager: UserManager = .shared) { self.userManager = userManager }

    // MARK: - Properties

    private var userManager: UserManager!

    // MARK: - API

    func loginUser(body: LoginBody) async throws {
        let encodedData = try? JSONEncoder().encode(body)
        let request = Request(body: encodedData)
        do {
            let data = try await makeRequest(request: request)
            let user = try JSONDecoder().decode(User.self, from: data)
            userManager.setup(user)
        } catch {
            throw error
        }
    }

    private struct Request: APIRequest {
        var method: HTTPMethod = .post
        var path: APIPath = .login
        var body: Data?
    }
}
