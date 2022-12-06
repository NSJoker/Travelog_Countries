//
//  BookmarksCoordinator.swift
//  Countries
//
//  Created by Chandrachudh K on 30/11/22.
//

import Combine
import Foundation
import UIKit

class BookmarksCoordinator: BaseCoordinator {
    // MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()
    
    override func start(navigationController: UINavigationController) {
        let bookmarksViewModel = BookmarksViewModel(service: SearchService(), reviewStore: ReviewUserDefaultStorage.shared)
        
        let bookmarksViewController = BookmarksViewController(bookmarksViewModel: bookmarksViewModel)
        let presentationNavigationController = UINavigationController(rootViewController: bookmarksViewController)
        presentationNavigationController.isNavigationBarHidden = true
        
        bookmarksViewModel.$dismiss
            .receive(on: DispatchQueue.main)
            .sink { [weak self] didDismiss in                
                if didDismiss {
                    navigationController.dismiss(animated: true)
                    guard let strongSelf = self else { return }
                    strongSelf.isCompleted?()
                }
            }
            .store(in: &subscriptions)
        
        bookmarksViewModel.$selectedCountry
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedCountry in
                guard let strongSelf = self, let selectedCountry = selectedCountry else { return }
                strongSelf.showDetails(for: selectedCountry.country,
                                       navigationController: presentationNavigationController)
            }
            .store(in: &subscriptions)
        
        navigationController.present(presentationNavigationController, animated: true)
    }
    
    // MARK: Private Methods
    private func showDetails(for country: Country, navigationController: UINavigationController) {
        let countryViewModel = CountryDetailsViewModel(country: country, reviewsManager: ReviewUserDefaultStorage.shared)
        let detailsCoordinator = DetailsCoordinator(countryViewModel: countryViewModel)
        store(coordinator: detailsCoordinator)
        
        detailsCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: detailsCoordinator)
        }
        
        detailsCoordinator.start(navigationController: navigationController)
    }
}
