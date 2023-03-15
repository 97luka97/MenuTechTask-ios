//
//  SplashViewController.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - Properties

    private let userManager: UserManager

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if userManager.isLoggedIn {
            let venuesListVC = VenuesListViewController(viewModel: .init())
            navigationController?.pushViewController(venuesListVC, animated: true)
        } else {
            openLoginVC()
        }
    }
    // MARK: - Init

    init(userManager: UserManager = .shared) {
        self.userManager = userManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - API

    func openLoginVC() {
        let loginVC = LoginViewController(viewModel: .init())
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
