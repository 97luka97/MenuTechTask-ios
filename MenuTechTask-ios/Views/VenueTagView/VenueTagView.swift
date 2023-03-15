//
//  VenueTagView.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 13.3.23..
//

import UIKit

class VenueTagView: UIView {

    // MARK: - Outlets

    @IBOutlet private weak var textLabel: UILabel!

    // MARK: - Init Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    // MARK: - API

    func setup(isOn: Bool, text: String) {
        backgroundColor = isOn ? CustomColor.orange100.uiColor : CustomColor.gray100.uiColor
        textLabel.text = text
    }
}

extension VenueTagView: NibLoadable {}
