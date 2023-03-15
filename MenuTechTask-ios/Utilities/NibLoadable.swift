//
//  NibLoadable.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

@IBDesignable
class NibView: UIView, NibLoadable {
    @IBInspectable var nibName: String? { didSet { xibSetup(nibName: nibName) } }
}

extension UIView {
    func loadNib(with nibName: String? = nil) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        guard let nibName = nibName ?? type(of: self).description().components(separatedBy: ".").last else {
            return nil
        }
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

protocol NibLoadable {
    func xibSetup(nibName: String?)
}

extension NibLoadable where Self: UIView {
    func xibSetup(nibName: String? = nil) {
        guard let view = loadNib(with: nibName) else {
            assertionFailure("🔴Could not load view from nib!")
            return
        }
        backgroundColor = .clear
        view.clipsToBounds = clipsToBounds
        embedToEdges(view)
    }
}
