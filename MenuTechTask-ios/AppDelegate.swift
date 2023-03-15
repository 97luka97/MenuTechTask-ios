//
//  AppDelegate.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        let splashVC = SplashViewController()
        let navController = UINavigationController(rootViewController: splashVC)
        navController.isNavigationBarHidden = true
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        return true
    }
}

