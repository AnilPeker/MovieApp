//
//  MovieCastResponseModel.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

struct MovieCastResponseModel: Codable {
    let id: Int
    let cast: [Cast]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
    }
}

struct Cast: Codable {
    let id: Int
    let originalName: String
    let profilePath: String?
    let castID: Int
    let character: String
    let creditID: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character = "character"
        case creditID = "credit_id"
    }
}
