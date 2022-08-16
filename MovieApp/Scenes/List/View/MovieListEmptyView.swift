//
//  MovieListEmptyView.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import UIKit
import Lottie

class MovieListEmptyView: UIView {
    override var isHidden: Bool {
        didSet {
            if isHidden {
                animationView.stop()
            } else {
                animationView.play()
            }
        }
    }
    
    lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 20
        return vStack
    }()
    
    lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "searchResult")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        return animationView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.text = "Result not Found"
        label.textAlignment = .center
        return label
    }()
    
    
    func setupUI() {
        addSubview(vStack)
        
        vStack.addArrangedSubview(animationView)
        vStack.addArrangedSubview(label)
        
        vStack.layout.centerVertically()
        vStack.layout.centerHorizontally()
    }
    
}
