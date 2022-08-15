//
//  VerticalTitleDescView.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation
import UIKit

class VerticalTitleDescView: UIView {
    lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 2
        return vStack
    }()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        label.textAlignment = .left
        return label
    }()
    
    lazy var descLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    func setupUI(title: String, desc: String) {
        titleLbl.text = title
        descLbl.text = desc
        vStack.addArrangedSubview(titleLbl)
        vStack.addArrangedSubview(descLbl)
        
        addSubview(vStack)
        
        vStack.layout.fillSuperview()
    }
    
    
    
}
