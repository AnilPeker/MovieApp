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
        collectionView.contentInset.left = 16
        collectionView.contentInset.right = 16
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return collectionView
    }()
    
    weak var delegate: CastCarouselOutput?
    private var castModel: [Cast] = []
    private var creditsModel: [CastMovieDetail] = []
    
    func setupUI(with model: [Cast]) {
        addSubview(collectionView)
        collectionView.layout.fillSuperview()
        self.castModel = model
        collectionView.reloadData()
    }
    
    func setupUI(with model: [CastMovieDetail]) {
        addSubview(collectionView)
        collectionView.layout.fillSuperview()
        self.creditsModel = model
        collectionView.reloadData()
    }
    
}
extension CastCarousel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        !castModel.isEmpty ? castModel.count: creditsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as! CastCell
        if !castModel.isEmpty{
            let model = self.castModel[indexPath.row]
            cell.setupUI(with: model)
        } else {
            let model = self.creditsModel[indexPath.row]
            cell.setupUI(with: model)
        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !castModel.isEmpty else { return }
        let id = castModel[indexPath.row].id
        self.delegate?.selectCast(personId: id)
    }
}
