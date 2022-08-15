//
//  MovieListVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 14.08.22.
//

import Foundation
import UIKit

class MovieListVC: UIViewController {
    
    var viewModel: MovieListVMDelegate!
    
    
}
extension MovieListVC: MovieListVMDelegateOutputs {
    func handleViewModelOutputs(_ outputs: MovieListVMOutputs) {
        switch outputs {
        case .reloadData:
            break
        case .fail(let string):
            break
        }
    }
}
