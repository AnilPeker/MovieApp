//
//  MovieListVM.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation

protocol MovieListVMCoordinatorProtocol {
    var goToDetail: (() -> ())? { get set }
}

protocol MovieListVMDelegate: MovieListVMCoordinatorProtocol {
    var delegate: MovieListVMDelegateOutputs? { get set }
    func fetchMovies()
}

protocol MovieListVMDelegateOutputs: AnyObject {
    func handleViewModelOutputs(_ outputs: MovieListVMOutputs)
}

enum MovieListVMOutputs {
    case reloadData
    case fail(String)
}

class MovieListVM: MovieListVMDelegate {
    weak var delegate: MovieListVMDelegateOutputs? //Note: Maked weak to be carefull memory management.
    var goToDetail: (() -> ())?
    
    func fetchMovies() {
        
    }
}
