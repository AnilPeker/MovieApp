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
        imageView.image = nil
        imageView.removeFromSuperview()
        addSubview(imageView)
        imageView.layout.fillSuperview()
        imageView.setImage(with: imagePath, size: .w185)
    }
    
}
