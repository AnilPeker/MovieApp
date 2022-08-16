//
//  CharacterCreditsResponseModel.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation


struct CharacterCreditsResponseModel: Codable {
    let cast: [CastMovieDetail]
}

struct CastMovieDetail: Codable {
    let character: String
    let title: String
    let id: Int
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case character
        case title
        case id
        case posterPath = "poster_path"
    }
}
