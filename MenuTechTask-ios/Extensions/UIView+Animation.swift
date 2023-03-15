//
//  UIView+Animation.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

extension UIView {
    func shakeAnimation(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
            self.transform = CGAffineTransform.identity
        },
            completion: nil
        )
    }
}
