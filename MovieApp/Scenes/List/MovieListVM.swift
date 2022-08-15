//
//  MovieListVM.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

protocol MovieListVMCoordinatorProtocol {
    var goToDetail: (() -> ())? { get set }
}

protocol MovieListVMDelegate: MovieListVMCoordinatorProtocol {
    var delegate: MovieListVMDelegateOutputs? { get set }
    var movies: [Movie] { get set }
    func fetchMostPopularMovies()
}

protocol MovieListVMDelegateOutputs: AnyObject {
    func handleViewModelOutputs(_ outputs: MovieListVMOutputs)
}

enum MovieListVMOutputs {
    case reloadData
    case fail(String)
}

class MovieListVM: MovieListVMDelegate {
    weak var delegate: MovieListVMDelegateOutputs? //Note: Maked weak to be carefull memory management.
    private let service: MovieServiceProtocol = Api()
    var movies: [Movie] = []
    var goToDetail: (() -> ())?
    
    private var page: Int = 1
    private var totalPage: Int = 0
    
    func fetchMostPopularMovies() {
        guard page != totalPage else { return }
        
        let queryItems: [String: String] = ["api_key": ApiConstants.apiKey,
                                            "page": "\(page + 1)"]
        service.getMostPopularMovies(queryItems: queryItems) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                let page = data.page
                let movies = data.results
                let totalPage = data.totalPages
                self.page = page
                self.totalPage = totalPage
                self.movies.appends(movies)
                self.notify(output: .reloadData)
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    private func notify(output: MovieListVMOutputs) {
        self.delegate?.handleViewModelOutputs(output)
    }
}
