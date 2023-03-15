//
//  VenuesTests.swift
//  MenuTechTask-iosTests
//
//  Created by Kostic on 15.3.23..
//

import XCTest
@testable import MenuTechTask_ios

final class VenuesTests: XCTestCase {

    func testDecode_venues() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "VenuesList", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("File not found")
        }
        let decoder = JSONDecoder()
        let venues = try? decoder.decode(VenuesList.self, from: data)
        XCTAssertNotNil(venues)
        XCTAssertEqual(venues?.venues?.count, 1)
    }
}
