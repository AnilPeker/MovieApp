//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation
import UIKit

// This is the basic coordinator of app
class AppCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = makeSplash()
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
// MARK: - Show Functions
private extension AppCoordinator {
    func showMovieList() {
        let viewController = makeMovieList()
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.viewControllers = [viewController]
    }
    
    func showMovieDetail(movieId: Int) {
        let viewController = makeMovieDetail(movieId: movieId)
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCharacterDetail(personId: Int) {
        let viewController = makeCharacterDetail(personId: personId)
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Controller Factory
private extension AppCoordinator {
    func makeSplash() -> SplashVC {
        let viewController = SplashVC()
        viewController.showMovieList = showMovieList
        return viewController
    }
    
    func makeMovieList() -> MovieListVC {
        let viewController = MovieListVC()
        let viewModel = MovieListVM()
        viewModel.delegate = viewController
        viewModel.showMovieDetail = showMovieDetail(movieId:)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func makeMovieDetail(movieId: Int) -> MovieDetailVC {
        let viewController = MovieDetailVC()
        let viewModel = MovieDetailVM(with: movieId)
        viewModel.delegate = viewController
        viewModel.showCharacterDetail = showCharacterDetail(personId:)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func makeCharacterDetail(personId: Int) -> CharacterDetailVC {
        let viewController = CharacterDetailVC()
        let viewModel = CharacterDetailVM(with: personId)
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        return viewController
    }
}
