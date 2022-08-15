//
//  MovieCell.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation
import UIKit
import Kingfisher

final class MovieCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func awakeFromNib() {
        setupUI()
    }
    
    private func setupUI() {
        imageView.layout.fillSuperview()
    }
    
    func updateUI(imagePath: String) {
        let url = URL(string: ApiConstants.imageBaseUrl + imagePath)
        let placeholder = ImagePlaceholder()
        imageView.kf.setImage(with: url,
                              placeholder: placeholder,
                              options: [.transition(.fade(0.2)), .cacheMemoryOnly])

    }
    
}
