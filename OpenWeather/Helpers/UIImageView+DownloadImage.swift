//
//  UIImageView+DownloadImage.swift
//  OpenWeather
//
//  Created by Carlos on 29/5/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImageWithThirdPartyLibrary(fromUrl: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: fromUrl,
            placeholder: nil,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
