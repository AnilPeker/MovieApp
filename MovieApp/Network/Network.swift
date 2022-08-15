//
//  Network.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol NetworkProtocol {
    func get<T: Decodable>(from endpoint: String, queryItems: [String : String], showSpinner: Bool, completion: @escaping (Result<T,NetworkError>) -> ())
}

final class Network: NetworkProtocol {
    private let executer: ExecuterProtocol

    init(_ executer: ExecuterProtocol = NetworkManager()) {
        self.executer = executer
    }

    func get<T>(from endpoint: String,
                queryItems: [String : String],
                showSpinner: Bool = true,
                completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable {
        
        var urlComponent = URLComponents(string: endpoint) 
        var queryItemsArray: [URLQueryItem] = []
        queryItems.forEach { (key: String, value: String) in
            queryItemsArray.append(URLQueryItem(name: key, value: value))
        }
        urlComponent?.queryItems = queryItemsArray
        
        guard let url = urlComponent?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
        self.executer.execute(urlRequest, showSpinner: showSpinner, completion: completion).resume()
    }
    
    func getImage(from endpoint: String,
                  completion: @escaping (Result<Data, NetworkError>) -> ()) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
    }
}
