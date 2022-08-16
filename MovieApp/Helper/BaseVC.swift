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
    
    private func setupKeyboardOutsideTap() {
        let tapView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapView.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapView)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        // To be sure that class will deinit
        
        print("--------------------------------------------------")
        print("----------\(self.classForCoder) Deinit----------------")
        print("--------------------------------------------------")
    }
}
