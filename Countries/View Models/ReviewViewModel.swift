//
//  ReviewViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 28/11/22.
//

import Foundation

class ReviewViewModel {
    // MARK: Private Properties
    private let review:Review
    
    // MARK: Public Properties
    var title: String {
        review.headline
    }
    
    var userReview: String {
        review.review
    }
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let date = Date(timeIntervalSince1970: review.createdDate)
        return dateFormatter.string(from: date)
    }
    
    init(review: Review) {
        self.review = review
    }
}
