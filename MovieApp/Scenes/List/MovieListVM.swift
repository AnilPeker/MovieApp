//
//  MovieListVM.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

protocol MovieListVMCoordinatorProtocol {
    var showMovieDetail: ((Int) -> ())? { get set }
}

protocol MovieListVMDelegate: MovieListVMCoordinatorProtocol {
    var delegate: MovieListVMDelegateOutputs? { get set }
    var movies: [Movie] { get set }
    var searchText: String { get set }
    func fetchMovies()
}

protocol MovieListVMDelegateOutputs: AnyObject {
    func handleViewModelOutputs(_ outputs: MovieListVMOutputs)
}

enum MovieListVMOutputs {
    case reloadData
    case resultNotFound
    case fail(String)
}

class MovieListVM: MovieListVMDelegate {
    weak var delegate: MovieListVMDelegateOutputs? //Note: Maked weak to be carefull memory management.
    private let service: MovieServiceProtocol = Api()
    private var dispatchWorkItem: DispatchWorkItem?
    var movies: [Movie] = []
    var searchText: String = "" {
        didSet {
            guard searchText.count > 0 || movies.isEmpty else { return }
            resetList()
            dispatchWorkItem?.cancel()
            dispatchWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.fetchMovies()
            }
            
            // To wait until writing over
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.5, execute: dispatchWorkItem!)
        }
    }
    var showMovieDetail: ((Int) -> ())?
    
    private var page: Int = 1
    private var totalPage: Int = 0
    
    func fetchMovies() {
        if searchText.count < 2 {
            fetchMostPopularMovies()
        } else {
            fetchSearch()
        }
    }
    
    
    func fetchMostPopularMovies() {
        guard page != totalPage else { return }
        
        let queryItems: [String: String] = ["api_key": ApiConstants.apiKey,
                                            "page": "\(page)"]
        service.getMostPopularMovies(queryItems: queryItems) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                let page = data.page
                let movies = data.results
                let totalPage = data.totalPages
                self.page = page + 1
                self.totalPage = totalPage
                self.movies.appends(movies)
                self.movies.isEmpty ? self.notify(output: .resultNotFound):
                                      self.notify(output: .reloadData)
                
                
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    func fetchSearch() {
        guard page != totalPage else { return }
        
        let queryItems: [String: String] = ["api_key": ApiConstants.apiKey,
                                            "query": searchText,
                                            "page": "\(page)"]
        
        service.getSearchedMovies(queryItems: queryItems) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                let page = data.page
                let movies = data.results
                let totalPage = data.totalPages
                self.page = page + 1
                self.totalPage = totalPage
                self.movies.appends(movies)
                self.movies.isEmpty ? self.notify(output: .resultNotFound):
                                      self.notify(output: .reloadData)
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    func resetList() {
        movies = []
        page = 1
        totalPage = 0
        notify(output: .reloadData)
    }
    
    private func notify(output: MovieListVMOutputs) {
        self.delegate?.handleViewModelOutputs(output)
    }
}
