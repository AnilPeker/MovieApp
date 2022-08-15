//
//  CastCarousel.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation
import UIKit

protocol CastCarouselDelegate {
    var delegate: CastCarouselOutput? { get set }
}

protocol CastCarouselOutput: AnyObject {
    func selectCast(personId: Int)
}

class CastCarousel: UIView, CastCarouselDelegate {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CastCell.itemSize
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.left = 10
        collectionView.contentInset.right = 10
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return collectionView
    }()
    
    weak var delegate: CastCarouselOutput?
    private var model: [Cast] = []
    
    func setupUI(with model: [Cast]) {
        addSubview(collectionView)
        collectionView.layout.fillSuperview()
        self.model = model
        collectionView.reloadData()
    }
    
}
extension CastCarousel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as! CastCell
        let model = self.model[indexPath.row]
        cell.setupUI(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = model[indexPath.row].id
        self.delegate?.selectCast(personId: id)
    }
}
