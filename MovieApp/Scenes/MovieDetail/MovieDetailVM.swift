//
//  MovieDetailVM.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

protocol MovieDetailVMCoordinatorProtocol {
    var goToCharacter: (() -> ())? { get set }
}

protocol MovieDetailVMDelegate: MovieDetailVMCoordinatorProtocol {
    var delegate: MovieDetailVMDelegateOutputs? { get set }
    
    var model: MovieDetailResponseModel? { get set }
    var castModel: [Cast] { get set }
    var videosModel: [Video] { get set }
    
    func fetchDetails()
}

protocol MovieDetailVMDelegateOutputs: AnyObject {
    func handleViewModelOutputs(_ outputs: MovieDetailVMOutputs)
}

enum MovieDetailVMOutputs {
    case movieDetailFetched
    case castFetched
    case videosFetched
    case fail(String)
}

class MovieDetailVM: MovieDetailVMDelegate {
    private var movieId: Int
    private let service: MovieDetailServiceProtocol = Api()
    weak var delegate: MovieDetailVMDelegateOutputs?
    var model: MovieDetailResponseModel?
    var castModel: [Cast] = []
    var videosModel: [Video] = []
    var goToCharacter: (() -> ())?
    
    init(with movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchDetails() {
        service.getMovieDetail(with: movieId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.model = data
                self.fetchCast()
                //self.fetchVideos()
                self.notify(output: .movieDetailFetched)
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    func fetchCast() {
        service.getMovieCast(with: movieId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.castModel = data.cast
                self.notify(output: .castFetched)
            case .failure(_):
                self.notify(output: .castFetched)
            }
        }
    }
    
    func fetchVideos() {
        service.getMovieVideo(with: movieId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.videosModel = data.results
                self.notify(output: .videosFetched)
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    private func notify(output: MovieDetailVMOutputs) {
        self.delegate?.handleViewModelOutputs(output)
    }
}
