//
//  CharacterDetailVC.swift
//  MovieApp
//
//  Created by Anıl Peker on 16.08.22.
//

import Foundation
import UIKit

class CharacterDetailVC: BaseVC {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset.bottom = 50
        return scrollView
    }()
    
    private lazy var vStack: UIStackView = {
        return UIView.makeVStack(with: 0,spacing: 16)
    }()
    
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return imageView
    }()
    
    private lazy var personNameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var personSummaryLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var castCarousel: CastCarousel = {
        let castCarousel = CastCarousel()
        castCarousel.delegate = self
        castCarousel.translatesAutoresizingMaskIntoConstraints = false
        castCarousel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return castCarousel
    }()
    
    var viewModel: CharacterDetailVMDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set background and title
        title = Constants.pageTitle.description
        view.backgroundColor = .white
        
        // Fetch detail data in viewDidLoad
        viewModel.fetchCharacterDetails()
        
        // Configure Layout
        configureScrollViewAndStackView()
    }
    
    private func configureScrollViewAndStackView() {
        // Scroll View - VStack relationship
        scrollView.addSubview(vStack)
        view.addSubview(scrollView)
        
        // VStack must be equal to scroll view height but height priorty must be low because VStack can decide its own height according to its subviews.
        vStack.layout.fillSuperview()
        let height = vStack.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        height.priority = .defaultLow
        height.isActive = true
        vStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        
        // Add Constraints to UIScrollView - UIViewController
        scrollView.layout.pinHorizontalEdgesToSuperView(padding: 0)
        scrollView.layout.pinTopToSuperview(constant: 100)
        scrollView.layout.pinBottomToSuperview(constant: 0)
    }
    
    private func setupUI() {
        // Set service data to view
        personImageView.setImage(with: viewModel.characterModel?.profilePath ?? "", size: .h632)
        personNameLbl.text = viewModel.characterModel?.name ?? ""
        personSummaryLbl.text = viewModel.characterModel?.biography ?? ""
        
        // Add subviews to VStack
        vStack.addArrangedSubview(personImageView)
        let innerVStack = UIView.makeVStack(with: 16, spacing: 10)
        innerVStack.addArrangedSubview(personNameLbl)
        innerVStack.addArrangedSubview(UIView.makeSeperator())
        innerVStack.addArrangedSubview(personSummaryLbl)
        innerVStack.addArrangedSubview(UIView.makeSeperator())
        
        vStack.addArrangedSubview(innerVStack)
        vStack.addArrangedSubview(castCarousel)
        vStack.addArrangedSubview(UIView.makeSeperator())
    }
    
}

// MARK: - Cast Carousel Output
extension CharacterDetailVC: CastCarouselOutput {
    func selectCast(personId: Int) {}
}

// MARK: - Outputs
extension CharacterDetailVC: CharacterDetailVMDelegateOutputs {
    func handleViewModelOutputs(_ outputs: CharacterDetailVMOutputs) {
        switch outputs {
        case .detailFetched:
            setupUI()
        case .creditsFetched:
            castCarousel.isHidden = viewModel.creditsModel.isEmpty
            castCarousel.setupUI(with: viewModel.creditsModel)
        case .fail(let string):
            showErrorPopup(string)
        }
    }
}

extension CharacterDetailVC {
    enum Constants: String, CustomStringConvertible {
        case pageTitle = "Person Detail"
        
        var description: String { return self.rawValue }
    }
}
