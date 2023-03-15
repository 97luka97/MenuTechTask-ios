//
//  LoginTextField.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

class LoginTextField: UIView {

    // MARK: - Outlets

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!

    // MARK: - Properties

    var input: String { textField.text ?? "" }

    // MARK: - Init Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        xibSetup()
        errorLabel.text = "Invalid input" // NOTE: Should get strings from localization file
    }

    // MARK: - API

    func setup(isEmail: Bool) {
        textField.isSecureTextEntry = !isEmail
        textField.keyboardType = isEmail ? .emailAddress : .default
        textField.placeholder = isEmail ? "Email" : "Password"
        textField.text = isEmail ? "test@testmenu.app" : "test1234"
    }

    func fireErrorIfNeeded(_ shouldFireError: Bool) {
        errorLabel.isHidden = !shouldFireError
        if shouldFireError { shakeAnimation() }
    }
}

extension LoginTextField: NibLoadable { }
