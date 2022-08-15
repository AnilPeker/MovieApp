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
// MARK: - Controller Factory
private extension AppCoordinator {
    func makeMovieList() -> MovieListVC {
        let viewController = MovieListVC()
        let viewModel = MovieListVM()
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        return viewController
    }
}
