//
//  MoviesService.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

protocol MovieServiceProtocol {
    func getMostPopularMovies(queryItems: [String: String], showSpinner: Bool, completion: @escaping (Result<MoviesResponseModel,NetworkError>) -> Void)
    func getSearchedMovies(queryItems: [String: String], completion: @escaping (Result<MoviesResponseModel,NetworkError>) -> Void)
}

extension Api: MovieServiceProtocol {
    func getMostPopularMovies(queryItems: [String: String], showSpinner: Bool, completion: @escaping (Result<MoviesResponseModel, NetworkError>) -> Void) {
        network.get(from: ApiConstants.getPopularMovie, queryItems: queryItems, showSpinner: showSpinner, completion: completion)
    }
    
    func getSearchedMovies(queryItems: [String : String], completion: @escaping (Result<MoviesResponseModel, NetworkError>) -> Void) {
        network.get(from: ApiConstants.getSearchMovie, queryItems: queryItems, showSpinner: true, completion: completion)
    }
    
}
