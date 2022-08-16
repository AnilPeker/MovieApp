//
//  CharacterDetailVM.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation
protocol CharacterDetailVMCoordinatorProtocol {}

protocol CharacterDetailVMDelegate: CharacterDetailVMCoordinatorProtocol {
    var delegate: CharacterDetailVMDelegateOutputs? { get set }
    var characterModel: CharacterDetailResponseModel? { get set }
    var creditsModel: [CastMovieDetail] { get set }
    func fetchCharacterDetails()
}

protocol CharacterDetailVMDelegateOutputs: AnyObject {
    func handleViewModelOutputs(_ outputs: CharacterDetailVMOutputs)
}

enum CharacterDetailVMOutputs {
    case detailFetched
    case creditsFetched
    case fail(String)
}

class CharacterDetailVM: CharacterDetailVMDelegate {
    private let service: CharacterDetailServiceProtocol = Api()
    weak var delegate: CharacterDetailVMDelegateOutputs?
    var characterModel: CharacterDetailResponseModel?
    var creditsModel: [CastMovieDetail] = []
    private let personId: Int
    
    
    init(with personId: Int) {
        self.personId = personId
    }
    
    func fetchCharacterDetails() {
        service.getCharacterDetail(with: personId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.characterModel = data
                self.notify(output: .detailFetched)
                self.fetchCharacterCredits()
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    func fetchCharacterCredits() {
        service.getCharacterCredits(with: personId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.creditsModel = data.cast
                self.notify(output: .creditsFetched)
            case .failure(let error):
                self.notify(output: .fail(error.localizedDescription))
            }
        }
    }
    
    private func notify(output: CharacterDetailVMOutputs) {
        self.delegate?.handleViewModelOutputs(output)
    }
}
