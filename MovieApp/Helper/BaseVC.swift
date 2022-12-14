//
//  BaseVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation
import UIKit


class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardOutsideTap()
    }

    deinit {
        // To be sure that class will deinit
        
        log.debug("--------------------------------------------------")
        log.debug("----------\(self.classForCoder) Deinit----------------")
        log.debug("--------------------------------------------------")
    }
}
// MARK: - Keyboard Dismisser
extension BaseVC {
    private func setupKeyboardOutsideTap() {
        let tapView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapView.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapView)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Error Popup
extension BaseVC {
    func showErrorPopup(_ message: String) {
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertView, animated: true)
    }
}
