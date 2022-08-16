//
//  CastCell.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation
import UIKit
import Kingfisher

class CastCell: UICollectionViewCell {
    static var itemSize: CGSize {
        let width = 300
        let height = 100
        return CGSize(width: width, height: height)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.spacing = 5
        return hStack
    }()
    
    lazy var personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    
    lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = 3
        return vStack
    }()
    
    lazy var castName: VerticalTitleDescView = {
        let titleDescView = VerticalTitleDescView()
        titleDescView.translatesAutoresizingMaskIntoConstraints = false
        return titleDescView
    }()
    
    lazy var originalName: VerticalTitleDescView = {
        let titleDescView = VerticalTitleDescView()
        titleDescView.translatesAutoresizingMaskIntoConstraints = false
        return titleDescView
    }()
    
    
    func setupUI(with model: Cast) {
        originalName.setupUI(title: "Name", desc: model.originalName)
        castName.setupUI(title: "Character", desc: model.character)
        personImage.setImage(with: model.profilePath ?? "")
        
        setupLayout()
    }
    
    func setupUI(with model: CastMovieDetail) {
        originalName.setupUI(title: "Film Name", desc: model.title)
        castName.setupUI(title: "Character", desc: model.character)
        personImage.setImage(with: model.posterPath ?? "")
        
        setupLayout()
    }
    
    private func setupLayout() {
        backgroundColor = .blue.withAlphaComponent(0.2)
        vStack.addArrangedSubview(originalName)
        vStack.addArrangedSubview(castName)
        
        hStack.addArrangedSubview(personImage)
        hStack.addArrangedSubview(vStack)
        
        addSubview(hStack)
        
        hStack.layout.fillSuperview(padding: 8)
        
        self.roundCorners(radius: 8)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
    }
    
}
