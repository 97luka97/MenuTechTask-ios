//
//  LoginViewController.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!

    // MARK: - Properties

    private let viewModel: LoginViewModel

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setup(isEmail: true)
        passwordTextField.setup(isEmail: false)
    }

    // MARK: - Init

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @IBAction private func signInButtonTapped(_ sender: UIButton) {
        if isValidInput() {
            Task {
                showSpinner()
                do {
                    try await viewModel.login(body: .init(email: emailTextField.input, password: passwordTextField.input))
                    showVenuesListVC()
                } catch {
                    showAlert(alertText: "Error", alertMessage: error.customErrorString)
                }
                hideSpinner()
            }
        }
    }

    // MARK: - Helpers

    private func isValidInput() -> Bool {
        let isValidEmail = emailTextField.input.isValidEmail
        let isValidPassword = passwordTextField.input.isValidPassword
        emailTextField.fireErrorIfNeeded(!isValidEmail)
        passwordTextField.fireErrorIfNeeded(!isValidPassword)
        return isValidEmail && isValidPassword
    }


    private func showVenuesListVC() {
        let venuesListVC = VenuesListViewController(viewModel: .init())
        navigationController?.pushViewController(venuesListVC, animated: true)
    }
}
