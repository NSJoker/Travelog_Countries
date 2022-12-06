//
//  NewReviewViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 30/11/22.
//

import Combine
import Foundation

class NewReviewViewModel {
    // MARK: Publishers
    @Published var dismiss = false
    
    // MARK: Public Properties
    let countryName: String
    
    // MARK: Private Properties
    private let reviewsManager: ReviewStoreProtocol
    
    init(countryName: String, reviewsManager: ReviewStoreProtocol) {
        self.countryName = countryName
        self.reviewsManager = reviewsManager
    }
    
    // MARK: Public Methods
    func dismissReviewPage() {
        dismiss = true
    }
    
    func saveReview(title: String?, review: String) {
        let review = Review(headline: title ?? "",
                            review: review,
                            createdDate: Date().timeIntervalSince1970,
                            countryName: countryName)
        
        self.reviewsManager.save(review: review)
        dismiss = true
    }
}
