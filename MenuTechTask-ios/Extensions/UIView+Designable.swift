//
//  UIView+Designable.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }

    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
        clipsToBounds = radius > 0
    }
}
