//
//  ImagePlaceholder.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation
import UIKit
import Kingfisher

class ImagePlaceholder: UIView, Placeholder {
    func setupUI() {
        let backgroundColor: UIColor = .black.withAlphaComponent(0.2)
        self.backgroundColor = backgroundColor
    }
}
