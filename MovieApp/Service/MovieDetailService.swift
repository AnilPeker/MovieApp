//
//  MovieDetailService.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

protocol MovieDetailServiceProtocol {
    func getMovieDetail(with movieId: Int, completion: @escaping (Result<MovieDetailResponseModel,NetworkError>) -> Void)
    func getMovieCast(with movieId: Int, completion: @escaping (Result<MovieCastResponseModel,NetworkError>) -> Void)
    func getMovieVideo(with movieId: Int, completion: @escaping (Result<MovieVideosModel,NetworkError>) -> Void)
}

extension Api: MovieDetailServiceProtocol {
    func getMovieDetail(with movieId: Int, completion: @escaping (Result<MovieDetailResponseModel, NetworkError>) -> Void) {
        let url = String(format: ApiConstants.getMovieDetail, "\(movieId)")
        network.get(from: url, queryItems: ["api_key": ApiConstants.apiKey],
                    showSpinner: true, completion: completion)
    }
    
    func getMovieCast(with movieId: Int, completion: @escaping (Result<MovieCastResponseModel, NetworkError>) -> Void) {
        let url = String(format: ApiConstants.getMovieCast, "\(movieId)")
        network.get(from: url, queryItems: ["api_key": ApiConstants.apiKey],
                    showSpinner: true, completion: completion)
    }
    
    func getMovieVideo(with movieId: Int, completion: @escaping (Result<MovieVideosModel, NetworkError>) -> Void) {
        let url = String(format: ApiConstants.getMovieVideos, "\(movieId)")
        network.get(from: url, queryItems: ["api_key": ApiConstants.apiKey],
                    showSpinner: true, completion: completion)
    }
}
