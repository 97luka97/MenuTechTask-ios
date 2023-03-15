//
//  CustomColor.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 14.3.23..
//

import UIKit

enum CustomColor: String, CaseIterable {

    // MARK: Init

    init(hex: String, fallbackColor: CustomColor) {
        self = CustomColor(hex: hex) ?? fallbackColor
    }

    init?(hex: String) {
        guard let color = Self.allCases.first(where: { $0.uiColor.hexValue == hex }) else { return nil }
        self = color
    }

    // MARK: Brand colors

    case black20
    case black40
    case black60
    case black80
    case black100
    case gray100
    case orange100

    // MARK: - Properties

    var uiColor: UIColor { UIColor(named: rawValue) ?? fallbackColor }
    var cgColor: CGColor { uiColor.cgColor }
}

extension CustomColor {
    private var fallbackColor: UIColor {
        switch self {
        case .black20: return UIColor(hex: "2C2C31").withAlphaComponent(0.2)
        case .black40: return UIColor(hex: "2C2C31").withAlphaComponent(0.4)
        case .black60: return UIColor(hex: "2C2C31").withAlphaComponent(0.6)
        case .black80: return UIColor(hex: "2C2C31").withAlphaComponent(0.8)
        case .black100: return UIColor(hex: "2C2C31")
        case .gray100: return UIColor(hex: "ABABAD")
        case .orange100: return UIColor(hex: "F2613D")
        }
    }
}

extension UIColor {
    convenience init (hex: String) {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 1.0, hex = hex

        if hex.hasPrefix("#") { hex = String(hex.dropFirst()) }

        let scanner = Foundation.Scanner(string: hex)
        var hexValue: UInt64 = 0
        if scanner.scanHexInt64(&hexValue) {
            if hex.count == 8 {
                red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat((hexValue & 0x000000FF)) / 255.0
            } else if hex.count == 6 {
                red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat((hexValue & 0x0000FF)) / 255.0
            }
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    var hexValue: String? { toHex() }

    func toHex(includeAlpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else { return nil }

        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        var alpha = Float(1.0)

        if components.count >= 4 { alpha = Float(components[3]) }

        if includeAlpha {
            return String(
                format: "%02lX%02lX%02lX%02lX",
                lroundf(red * 255),
                lroundf(green * 255),
                lroundf(blue * 255),
                lroundf(alpha * 255)
            )
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
        }
    }
}
