//
//  MovieListEmptyView.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import UIKit

class MovieListEmptyView: UIView {
    lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 10
        return vStack
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.text = "Result not Found"
        return label
    }()
    
    
    func setupUI() {
        addSubview(vStack)
        
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(label)
        
        vStack.layout.centerVertically()
        vStack.layout.centerHorizontally()
    }
    
}
