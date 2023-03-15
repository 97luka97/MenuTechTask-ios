//
//  UIViewController+Extensions.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showAlert(alertText: String, alertMessage: String) {
        let alert = UIAlertController(
            title: alertText,
            message: alertMessage,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIViewController {
    func showSpinner() {
        DispatchQueue.main.async {
            let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
            Indicator.isUserInteractionEnabled = false
            Indicator.show(animated: true)
        }
    }

    func hideSpinner() {
        DispatchQueue.main.async { MBProgressHUD.hide(for: self.view, animated: true) }
    }


}

