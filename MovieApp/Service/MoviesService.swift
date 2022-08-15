//
//  MoviesService.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

protocol MovieServiceProtocol {
    func getMostPopularMovies(queryItems: [String: String], completion: @escaping (Result<MoviesResponseModel,NetworkError>) -> Void)
}

extension Api: MovieServiceProtocol {
    func getMostPopularMovies(queryItems: [String: String], completion: @escaping (Result<MoviesResponseModel, NetworkError>) -> Void) {
        var urlComponent = URLComponents(string: ApiConstants.getPopularMovie)
        var queryItemsArray: [URLQueryItem] = []
        queryItems.forEach { (key: String, value: String) in
            queryItemsArray.append(URLQueryItem(name: key, value: value))
        }
        urlComponent?.queryItems = queryItemsArray
        network.get(from: urlComponent?.url?.absoluteString ?? "", showSpinner: true, completion: completion)
    }
}
