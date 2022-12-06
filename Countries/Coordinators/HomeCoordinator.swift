//
//  HomeCoordinator.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Combine
import Foundation
import UIKit

class HomeCoordinator: BaseCoordinator {
    // MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()
    private let searchViewModel = SearchViewModel(service: SearchService())
    
    override func start(navigationController: UINavigationController) {
        let homeViewController = HomeViewController(searchViewModel: searchViewModel)
        
        searchViewModel.$selectedCountry
            .receive(on: DispatchQueue.main)
            .sink { [weak self] country in
                guard let country = country else { return }
                self?.showDetails(of: country, navigationController: navigationController)
            }
            .store(in: &subscriptions)
        
        navigationController.pushViewController(homeViewController, animated: false)
        
        searchViewModel.$showBookMarks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldShowBookmark in
                if shouldShowBookmark {
                    self?.showBookmarks(navigationController: navigationController)
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: Private Methods
    private func showDetails(of country: Country, navigationController: UINavigationController) {
        let countryViewModel = CountryDetailsViewModel(country: country, reviewsManager: ReviewUserDefaultStorage.shared)
        let detailsCoordinator = DetailsCoordinator(countryViewModel: countryViewModel)
        store(coordinator: detailsCoordinator)
        
        detailsCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: detailsCoordinator)
        }
        
        detailsCoordinator.start(navigationController: navigationController)
    }
    
    private func showBookmarks(navigationController: UINavigationController) {
        let bookmarksCoordinator = BookmarksCoordinator()
        store(coordinator: bookmarksCoordinator)
        
        bookmarksCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: bookmarksCoordinator)
        }
        
        bookmarksCoordinator.start(navigationController: navigationController)
    }
}
