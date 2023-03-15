//
//  UINavigationController+Logout.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 14.3.23..
//

import UIKit

extension UINavigationController {
    func logout() {
        if let loginVC = viewControllers.first(where: { $0 is LoginViewController }) {
            popToViewController(loginVC, animated: true)
        } else {
            if let splashVC = viewControllers.first(where: { $0 is SplashViewController }) as? SplashViewController {
                popToRootViewController(animated: true)
                splashVC.openLoginVC()
            }
        }
    }
}
