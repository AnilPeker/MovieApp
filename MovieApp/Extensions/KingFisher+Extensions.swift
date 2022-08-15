//
//  KingFisher+Extensions.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with imagePath: String) {
        onMain { [weak self] in
            guard let self = self else { return }
            let url = URL(string: ApiConstants.imageBaseUrl + imagePath)
            let placeholder = ImagePlaceholder()
            placeholder.setupUI()
            self.kf.setImage(with: url,
                             placeholder: placeholder,
                             options: [.transition(.fade(0.2)), .cacheMemoryOnly])
        }
    }
}
