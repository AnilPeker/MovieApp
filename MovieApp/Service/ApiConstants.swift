//
//  ApiConstants.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

struct ApiConstants {
    static var apiKey: String {
        return "08d2288d7ccc72d92023954191affe9b"
    }
    
    static var baseUrl: String {
        return "https://api.themoviedb.org/3/"
    }
    
    static var imageBaseUrl: String {
        return "https://image.tmdb.org/t/p/"
    }
    
    static let getPopularMovie = baseUrl + "movie/popular"
    static let getSearchMovie = baseUrl + "search/movie"
    static let getMovieDetail = baseUrl + "movie/%@" //movieId
    static let getMovieCast = baseUrl + "movie/%@/credits" //movieId
    static let getMovieVideos = baseUrl + "movie/%@/videos" //movieId
    static let getCharacterDetail = baseUrl + "/person/%@" //movieId
    static let getCharacterCredits = baseUrl + "/person/%@/movie_credits" //movieId
}
