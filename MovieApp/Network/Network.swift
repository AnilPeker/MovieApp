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
        
        // Create url component
        var urlComponent = URLComponents(string: endpoint)
        
        // Append query items to url
        var queryItemsArray: [URLQueryItem] = []
        queryItems.forEach { (key: String, value: String) in
            queryItemsArray.append(URLQueryItem(name: key, value: value))
        }
        urlComponent?.queryItems = queryItemsArray
        
        // Check url is valid
        guard let url = urlComponent?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
        
        // Send request to executer
        self.executer.execute(urlRequest, showSpinner: showSpinner, completion: completion).resume()
    }
}
