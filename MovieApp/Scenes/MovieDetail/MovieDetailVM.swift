//
//  MovieDetailVM.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation

// Coordinator Protocol
protocol MovieDetailVMCoordinatorProtocol {
    var showCharacterDetail: ((Int) -> ())? { get set }
}

// View Model Delegate
protocol MovieDetailVMDelegate: MovieDetailVMCoordinatorProtocol {
    var delegate: MovieDetailVMDelegateOutputs? { get set }
    
    var model: MovieDetailResponseModel? { get set }
    var castModel: [Cast] { get set }
    var videosModel: [Video] { get set }
    
    func fetchDetails()
}

// Output Protocol - Connection between ViewModel-ViewController
protocol MovieDetailVMDelegateOutputs: AnyObject {
    func handleViewModelOutputs(_ outputs: MovieDetailVMOutputs)
}

// Output Types
enum MovieDetailVMOutputs {
    case movieDetailFetched
    case castFetched
    case videosFetched
    case fail(String)
}

class MovieDetailVM: MovieDetailVMDelegate {
    private let service: MovieDetailServiceProtocol = Api()
    weak var delegate: MovieDetailVMDelegateOutputs? //Note: Make it weak to be carefull memory management.
    
    // Model
    var model: MovieDetailResponseModel?
    var castModel: [Cast] = []
    var videosModel: [Video] = []
    
    // Coordinator
    var showCharacterDetail: ((Int) -> ())?
    
    // Variable
    private var movieId: Int
    
    init(with movieId: Int) {
        self.movieId = movieId
    }
    
    // Callback output to ViewController
    private func notify(output: MovieDetailVMOutputs) {
        self.delegate?.handleViewModelOutputs(output)
    }
}
// MARK: - Service
extension MovieDetailVM {
    func fetchDetails() {
        service.getMovieDetail(with: movieId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.model = data
                self.notify(output: .movieDetailFetched)
                self.fetchCast()
                self.fetchVideos()
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    private func fetchCast() {
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
    
    private func fetchVideos() {
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
}
