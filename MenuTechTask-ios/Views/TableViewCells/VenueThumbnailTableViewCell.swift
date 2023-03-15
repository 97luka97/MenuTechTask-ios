//
//  VenueThumbnailTableViewCell.swift
//  MenuTechTask-ios
//
//  Created by Kostic on 14.3.23..
//

import UIKit
import SDWebImage

class VenueThumbnailTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!

    // MARK: - API

    func loadImage(url: URL) {
        thumbnailImageView.sd_setImage(with: url) { _, _, _, _ in
            self.activityIndicator.stopAnimating()
        }
    }
}

extension VenueThumbnailTableViewCell: NibReusableCell {}
