//
//  UserManager.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

final class UserManager {

    // MARK: - Singleton

    static let shared = UserManager()

    // MARK: - UserDefaults

    enum UserManagerKey: String, UserDefaultsKey {
        case token

        var keyName: String { rawValue }
    }

    @UserDefaultsBacked(key: UserManagerKey.token, defaultValue: nil)
    var token: String?

    // MARK: - Properties

    private(set) var user: User?
    var isLoggedIn: Bool { !token.isNil }

    // MARK: - API

    func setup(_ user: User) {
        self.user = user
        token = user.token
    }

    func clear() {
        token = nil
        user = nil
    }
}
