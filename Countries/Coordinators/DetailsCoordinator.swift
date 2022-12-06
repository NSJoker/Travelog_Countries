//
//  DetailsCoordinator.swift
//  Countries
//
//  Created by Chandrachudh K on 25/11/22.
//

import Combine
import Foundation
import UIKit

class DetailsCoordinator: BaseCoordinator {
    // MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()
    private let countryViewModel: CountryDetailsViewModel
    
    init(countryViewModel: CountryDetailsViewModel) {
        self.countryViewModel = countryViewModel
    }
    
    override func start(navigationController: UINavigationController) {
        let detailsViewController = DetailsViewController(countryViewModel: countryViewModel)
        
        countryViewModel.$didTapBack
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldMoveBack in
                guard let strongSelf = self, shouldMoveBack else { return }
                navigationController.popViewController(animated: true)
                strongSelf.isCompleted?()
            }
            .store(in: &subscriptions)
        
        countryViewModel.$addReview
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldAddNewReview in
                guard let strongSelf = self, shouldAddNewReview else { return }
                strongSelf.showAddNewReviewView(navigationController: navigationController)
            }
            .store(in: &subscriptions)
        
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    // MARK: Private Methods
    private func showAddNewReviewView(navigationController: UINavigationController) {
        let newReviewCoordinator = NewReviewCoordinator(countryName: countryViewModel.officialName)
        store(coordinator: newReviewCoordinator)
        
        newReviewCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: newReviewCoordinator)
        }
        
        newReviewCoordinator.start(navigationController: navigationController)
    }
}
