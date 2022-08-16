//
//  MoviesResponseModel.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

// MARK: - Welcome
struct MoviesResponseModel: Codable {
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Movie: Codable {
    let posterPath: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
    }
}
