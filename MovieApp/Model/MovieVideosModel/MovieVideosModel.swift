//
//  MovieVideosModel.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation

struct MovieVideosModel: Codable {
    let id: Int
    let results: [Video]
}

struct Video: Codable {
    let name: String
    let site: String
}
