//
//  MovieListVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation
import UIKit

class MovieListVC: UIViewController {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = MovieCell.itemSize
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var viewModel: MovieListVMDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchMostPopularMovies()
    }
    
}
// MARK: - UI
extension MovieListVC {
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.layout.fillSuperview()
    }
}

extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let model = viewModel.movies[indexPath.row]
        cell.updateUI(imagePath: model.posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.count - 1 {
            viewModel.fetchMostPopularMovies()
        }
    }
    
}

extension MovieListVC: MovieListVMDelegateOutputs {
    func handleViewModelOutputs(_ outputs: MovieListVMOutputs) {
        switch outputs {
        case .reloadData:
            collectionView.reloadData()
            break
        case .fail(let string):
            break
        }
    }
}
