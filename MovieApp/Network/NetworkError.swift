//
//  NetworkError.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case custom(String?)
    case decoding(String?)
    case encoding(String?)
    case noData
}
