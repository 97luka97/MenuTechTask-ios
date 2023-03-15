//
//  UserDefaultsBacked.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import Foundation

protocol UserDefaultsKey {
    var keyName: String { get }
}

@propertyWrapper
struct UserDefaultsBacked<Value> {
    let key: UserDefaultsKey
    let defaultValue: Value
    var storage: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: key.keyName) as? Value
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key.keyName)
            } else {
                storage.setValue(newValue, forKey: key.keyName)
            }
        }
    }
}

extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
    init(key: UserDefaultsKey) {
        self.init(key: key, defaultValue: nil)
    }
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value): return value
        case .none: return ""
        }
    }
}
