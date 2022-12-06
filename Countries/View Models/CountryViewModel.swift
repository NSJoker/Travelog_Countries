//
//  CountryViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Combine
import Foundation

class CountryViewModel {
    // MARK: Publishers
    @Published var interest: Interest = .none
    
    // MARK: Public Properties
    let country: Country
    let reviewsManager: ReviewStoreProtocol
    var reviews: [Review] = []
    var subscriptions = Set<AnyCancellable>()
    
    final var reviewsCount: Int {
        reviews.count
    }
    
    final var flagURL: String {
        country.flags.png ?? ""
    }
    
    final var officialName: String {
        country.name.official
    }
    
    final var commonName: String {
        "(\(country.name.common))"
    }
    
    init(country: Country, reviewsManager: ReviewStoreProtocol) {
        self.country = country
        self.reviewsManager = reviewsManager
        self.reviews = reviewsManager.getAllReviews(of: country.name.official)
        
        interest = reviewsManager.getInterest(country: country.name.official)
    }
    
    // MARK: Public Methods
    final func shouldShowInSearch(searchText: String) -> Bool {
        (officialName.isSubstring(text: searchText) || commonName.isSubstring(text: searchText))
    }
}
