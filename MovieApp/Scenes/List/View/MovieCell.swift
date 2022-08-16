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
    
    // Item Size
    static var itemSize: CGSize {
        let width = UIScreen.main.bounds.width / 2
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
    
    // Cell Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func updateUI(imagePath: String) {
        // Reset View
        imageView.image = nil
        imageView.removeFromSuperview()
        
        // Add subview
        addSubview(imageView)
        imageView.layout.fillSuperview()
        
        // Set data
        imageView.setImage(with: imagePath, size: .w185)
    }
    
}
