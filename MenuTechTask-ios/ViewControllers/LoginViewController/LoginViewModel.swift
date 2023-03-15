//
//  LoginViewModel.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

final class LoginViewModel {

    // MARK: - Properties

    private var loginService: LoginServiceProtocol!

    // MARK: - Init

    init(loginService: LoginServiceProtocol = LoginService.shared) {
        self.loginService = loginService
    }

    // MARK: - API

    func login(body: LoginBody) async throws {
        do {
            try await loginService.loginUser(body: body)
        } catch {
            throw error
        }
    }
}
