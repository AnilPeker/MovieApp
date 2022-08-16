//
//  Spinner.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation
import Lottie

private var animationView: AnimationView?
private var spinnerContainer: UIView?

open class Spinner {
    static func start() {
        guard let window = UIWindow.key, spinnerContainer == nil else { return }
        spinnerContainer = UIView.init(frame: window.bounds)
        animationView = .init(name: "spinner")
        
        guard let spinnerContainer = spinnerContainer, let animationView = animationView else { return }
        
        spinnerContainer.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        animationView.frame = CGRect(x: 0, y: 0, width: 91, height: 91)
        animationView.center = window.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        spinnerContainer.addSubview(animationView)
        window.addSubview(spinnerContainer)
    }
    
    static func stop() {
        dispatchAfter(0.2) {
            spinnerContainer?.removeFromSuperview()
            spinnerContainer = nil
        }
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
