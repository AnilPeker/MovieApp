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
    static var itemSize: CGSize {
        let width = UIScreen.main.bounds.width / 2
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func updateUI(imagePath: String) {
        imageView.removeFromSuperview()
        addSubview(imageView)
        imageView.layout.fillSuperview()
        
        onMain { [weak self] in
            guard let self = self else { return }
            let url = URL(string: ApiConstants.imageBaseUrl + imagePath)
            let placeholder = ImagePlaceholder()
            self.imageView.kf.setImage(with: url,
                                       placeholder: placeholder,
                                       options: [.transition(.fade(0.2)), .cacheMemoryOnly])
        }
    }
    
}
