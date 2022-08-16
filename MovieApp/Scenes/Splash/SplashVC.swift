//
//  SplashVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation
import UIKit
import Lottie

class SplashVC: BaseVC {
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "movie")
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    var showMovieList: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .cyan.withAlphaComponent(0.5)
        view.addSubview(animationView)
        animationView.layout.fillSuperview(padding: 32)
        animationView.loopMode = .playOnce
        animationView.play { [weak self] _ in
            guard let self = self else { return }
            self.showMovieList?()
        }
    }
}
