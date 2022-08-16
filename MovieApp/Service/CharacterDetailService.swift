//
//  CharacterDetailService.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation

protocol CharacterDetailServiceProtocol {
    func getCharacterDetail(with personId: Int, completion: @escaping (Result<CharacterDetailResponseModel,NetworkError>) -> Void)
    func getCharacterCredits(with personId: Int, completion: @escaping (Result<CharacterCreditsResponseModel,NetworkError>) -> Void)
}

extension Api: CharacterDetailServiceProtocol {
    func getCharacterDetail(with personId: Int, completion: @escaping (Result<CharacterDetailResponseModel, NetworkError>) -> Void) {
        let url = String(format: ApiConstants.getCharacterDetail, "\(personId)")
        network.get(from: url, queryItems: ["api_key": ApiConstants.apiKey],
                    showSpinner: true, completion: completion)
    }
    
    func getCharacterCredits(with personId: Int, completion: @escaping (Result<CharacterCreditsResponseModel, NetworkError>) -> Void) {
        let url = String(format: ApiConstants.getCharacterCredits, "\(personId)")
        network.get(from: url, queryItems: ["api_key": ApiConstants.apiKey],
                    showSpinner: false, completion: completion)
    }
}
