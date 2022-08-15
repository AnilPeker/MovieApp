//
//  MovieListVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation
import UIKit

class MovieListVC: UIViewController {
    lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 10
        return vStack
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = Constants.searchPlaceholder.description
        searchBar.keyboardType = .default
        searchBar.autocorrectionType = .no
        return searchBar
    }()
    
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
    
    lazy var emptyView: MovieListEmptyView = {
       let emptyView = MovieListEmptyView()
        emptyView.setupUI()
        emptyView.isHidden = true
        return emptyView
    }()
    
    var viewModel: MovieListVMDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchMovies()
    }
    
}
// MARK: - UI
extension MovieListVC {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = Constants.pageTitle.description
        view.addSubview(vStack)
        vStack.addArrangedSubview(searchBar)
        vStack.addArrangedSubview(collectionView)
        vStack.addArrangedSubview(emptyView)
        vStack.layout.pinHorizontalEdgesToSuperView(padding: 0)
        vStack.layout.pinTopToSuperview(constant: 100)
        vStack.layout.pinBottomToSuperview(constant: 0)
    }
}

// MARK: - Collection View
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
        let movieId = viewModel.movies[indexPath.row].id ?? -1
        viewModel.showMovieDetail?(movieId)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.count - 1 {
            viewModel.fetchMovies()
        }
    }
    
}
// MARK: - Search
extension MovieListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
    
}
// MARK: - Outputs
extension MovieListVC: MovieListVMDelegateOutputs {
    func handleViewModelOutputs(_ outputs: MovieListVMOutputs) {
        switch outputs {
        case .reloadData:
            collectionView.isHidden = false
            emptyView.isHidden = true
            collectionView.reloadData()
        case .resultNotFound:
            collectionView.isHidden = true
            emptyView.isHidden = false
        case .fail(let string):
            break
        }
    }
}

extension MovieListVC {
    enum Constants: String, CustomStringConvertible {
        case pageTitle = "Filmler"
        case searchPlaceholder = "Arama"
        
        var description: String { return self.rawValue }
    }
}
