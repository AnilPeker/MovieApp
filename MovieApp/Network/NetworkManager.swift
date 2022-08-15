//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

final class NetworkManager: ExecuterProtocol {
    let session: URLSession
    
    public init(_ session: URLSession = NetworkDefaults().configure()) {
        self.session = session
    }
    
    public func execute<T>(_ urlRequest: URLRequest,
                           showSpinner: Bool = true,
                           completion: @escaping (Result<T,NetworkError>)->()) -> URLSessionDataTask where T: Decodable {
        
        
        return session.dataTask(with: urlRequest) { data, urlResponse, error in
            
            guard error == nil else {
                completion(.failure(.custom(error?.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            self.handleResponse(data, completion: completion)
        }
        
    }
    
    fileprivate func handleResponse<T>(_ data: Data, completion: @escaping (Result<T,NetworkError>)->()) where T: Decodable {
        do {
    
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            onMain {
                completion(.success(decodedData))
            }
            
        } catch {
            completion(.failure(.decoding("Decoding Error")))
        }
    }
}

extension NetworkManager {
    
}
