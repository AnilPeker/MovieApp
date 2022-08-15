//
//  ExecuterProtocol.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

protocol ExecuterProtocol {
    func execute<T>(_ urlRequest: URLRequest,
                    showSpinner: Bool,
                    completion: @escaping (Result<T,NetworkError>)->()) -> URLSessionDataTask where T : Decodable
    
}
