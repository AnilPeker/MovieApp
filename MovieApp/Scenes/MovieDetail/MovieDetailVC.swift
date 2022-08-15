//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 15.08.22.
//

import Foundation
import UIKit

class MovieDetailVC: UIViewController {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 16
        return vStack
    }()
    
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imageView
    }()
    
    lazy var movieNameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var movieSummaryLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var movieRatingView: VerticalTitleDescView = {
        let titleDescView = VerticalTitleDescView()
        titleDescView.translatesAutoresizingMaskIntoConstraints = false
        return titleDescView
    }()
    
    lazy var castCarousel: CastCarousel = {
        let castCarousel = CastCarousel()
        castCarousel.translatesAutoresizingMaskIntoConstraints = false
        castCarousel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return castCarousel
    }()
    
    lazy var videosHeaderLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.text = Constants.videos.description
        return label
    }()
    
    var viewModel: MovieDetailVMDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.fetchDetails()
    }
    
    private func setupUI() {
        configureScrollViewAndStackView()
        setupHeaderDesc()
        setupRating()
        setupCast()
    }
    
    private func configureScrollViewAndStackView() {
        scrollView.addSubview(vStack)
        view.addSubview(scrollView)
        
        vStack.layout.fillSuperview()
        let height = vStack.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        height.priority = .defaultLow
        height.isActive = true
        vStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        
        scrollView.layout.pinHorizontalEdgesToSuperView(padding: 0)
        scrollView.layout.pinTopToSuperview(constant: 100)
        scrollView.layout.pinBottomToSuperview(constant: 0)
    }
    
    private func setupHeaderDesc() {
        movieImage.setImage(with: viewModel.model?.posterPath ?? "")
        movieNameLbl.text = viewModel.model?.title ?? ""
        movieSummaryLbl.text = viewModel.model?.overview
        
        vStack.addArrangedSubview(movieImage)
        vStack.addArrangedSubview(movieNameLbl)
        vStack.addArrangedSubview(UIView.makeSeperator())
        vStack.addArrangedSubview(movieSummaryLbl)
        vStack.addArrangedSubview(UIView.makeSeperator())
    }
    
    private func setupRating() {
        let rating = viewModel.model?.voteAverage ?? 0
        movieRatingView.setupUI(title: Constants.rating.description, desc: String(rating))
    }
    
    private func setupCast() {
        vStack.addArrangedSubview(castCarousel)
    }
    
    private func setupVideos() {
        let videoArea = makeVideosArea(with: viewModel.videosModel)
        vStack.addArrangedSubview(videoArea)
    }
    
}
// MARK: - UI FACTORY
extension MovieDetailVC {
    private func makeVideosArea(with model: [Video]) -> UIStackView {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 5
        model.forEach { data in
            let titleDescView = VerticalTitleDescView()
            titleDescView.setupUI(title: data.name, desc: data.site)
            titleDescView.translatesAutoresizingMaskIntoConstraints = false
            vStack.addArrangedSubview(vStack)
        }
        return vStack
    }
}

// MARK: - Outputs
extension MovieDetailVC: MovieDetailVMDelegateOutputs {
    func handleViewModelOutputs(_ outputs: MovieDetailVMOutputs) {
        switch outputs {
        case .movieDetailFetched:
            setupUI()
        case .castFetched:
            castCarousel.isHidden = viewModel.castModel.isEmpty
            castCarousel.setupUI(with: viewModel.castModel)
        case .videosFetched:
            setupVideos()
        case .fail(let string):
            break
        }
    }
}

extension MovieDetailVC {
    enum Constants: String, CustomStringConvertible {
        case pageTitle = "Movie Detail"
        case videos = "Videos"
        case rating = "rating"
        
        var description: String { return self.rawValue }
    }
}
