//
//  Constants.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

struct Constants {
    static let baseURL = "https://api-qa.menu.app" // NOTE: Should be stored in Info.plist
    static let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
}
