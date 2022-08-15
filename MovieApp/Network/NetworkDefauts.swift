//
//  NetworkDefauts.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

final class NetworkDefaults: NSObject, URLSessionDelegate {
    
    func configure() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.httpMaximumConnectionsPerHost = 10
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        configuration.urlCache = .shared
         
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
}
