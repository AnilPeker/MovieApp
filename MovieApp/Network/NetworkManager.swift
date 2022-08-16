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
        // Start spinner if needed
        if showSpinner {
            Spinner.start()
        }
        
        // Start session
        return session.dataTask(with: urlRequest) { data, urlResponse, error in
            
            // Stop spinner after response
            Spinner.stop()
            
            // Check error
            guard error == nil else {
                onMain {
                    completion(.failure(.custom(error?.localizedDescription)))
                }
                return
            }
            
            // Check data is arrived
            guard let data = data else {
                onMain {
                    completion(.failure(.noData))
                }
                return
            }
            
            // Send data to decoder
            self.handleResponse(data, completion: completion)
        }
        
    }
    
    fileprivate func handleResponse<T>(_ data: Data, completion: @escaping (Result<T,NetworkError>)->()) where T: Decodable {
        do {
            // Decode service data
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            // Complete service call in main thread
            onMain {
                completion(.success(decodedData))
            }
            
        } catch {
            onMain {
                completion(.failure(.decoding("Decoding Error")))
            }
        }
    }
}

extension NetworkManager {
    
}
