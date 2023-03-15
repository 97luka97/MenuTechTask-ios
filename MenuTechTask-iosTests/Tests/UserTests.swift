//
//  UserTests.swift
//  MenuTechTask-iosTests
//
//  Created by Kostic on 13.3.23..
//

import XCTest
@testable import MenuTechTask_ios

final class UserTests: XCTestCase {

    func testDecode_user() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "User", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("File not found")
        }
        let decoder = JSONDecoder()
        let user = try? decoder.decode(User.self, from: data)
        XCTAssertNotNil(user)
    }
}
