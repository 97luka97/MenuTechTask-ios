//
//  HTTPURLResponse+Extensions.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

extension HTTPURLResponse {
    func isResponseOK() -> Bool {
        (200...299).contains(self.statusCode)
    }
}
