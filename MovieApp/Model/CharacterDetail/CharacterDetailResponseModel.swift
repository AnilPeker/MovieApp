//
//  CharacterDetailResponseModel.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation

// MARK: - Welcome
struct CharacterDetailResponseModel: Codable {
    let birthday: String
    let id: Int
    let name: String
    let biography: String
    let placeOfBirth: String
    let profilePath: String
    enum CodingKeys: String, CodingKey {
        case birthday
        case id
        case name
        case biography
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
    }
}
