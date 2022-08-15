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
        let viewController = makeMovieList()
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
// MARK: - Show Functions
private extension AppCoordinator {
    func showMovieDetail(movieId: Int) {
        let viewController = makeMovieDetail(movieId: movieId)
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}


// MARK: - Controller Factory
private extension AppCoordinator {
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
        viewController.viewModel = viewModel
        return viewController
    }
}
