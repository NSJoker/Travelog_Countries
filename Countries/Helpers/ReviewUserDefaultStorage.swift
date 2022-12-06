//
//  ReviewUserDefaultStorage.swift
//  Countries
//
//  Created by Chandrachudh K on 28/11/22.
//

import Combine
import Foundation
/**
 Currently utilising the most easiest storage method, using UserDefaults
 */
class ReviewUserDefaultStorage: ReviewStoreProtocol {
    static let shared = ReviewUserDefaultStorage()
    
    @Published var reviews: [Review]
    private let reviewStoragekey = "reviews"
    private let interestStoragekey = "interest"
    
    var reviewsPublisher: Published<[Review]>.Publisher { $reviews }
    
    private init() {
        guard let reviewsData = UserDefaults.standard.value(forKey: reviewStoragekey) as? [Data]  else {
            self.reviews = []
            return
        }
        
        var reviews = [Review]()
        let decoder = JSONDecoder()
        for data in reviewsData {
            if let review = try? decoder.decode(Review.self, from: data) {
                reviews.append(review)
            }
        }
        self.reviews = reviews
    }
    
    func getAllReviews() -> [Review] {
        return reviews
    }
    
    func save(review: Review) {
        reviews.append(review)
    }
    
    // Get Reviews using the offical name of the country
    func getAllReviews(of country: String) -> [Review] {
        self.reviews.filter({ $0.countryName == country })
    }
    
    func delete(review: Review) {
        reviews = reviews.filter({ $0.id != review.id })
    }
    
    func saveReviews() {
        UserDefaults.standard.removeObject(forKey: reviewStoragekey)
        let encoder = JSONEncoder()
        var reviewsData = [Data]()
        for review in reviews {
            if let encodedData = try? encoder.encode(review) {
                reviewsData.append(encodedData)
            }
        }
        UserDefaults.standard.set(reviewsData, forKey: reviewStoragekey)
    }
    
    private func save(encodedReview: Data) {
        guard var reviewsData = UserDefaults.standard.value(forKey: reviewStoragekey) as? [Data]  else {
            
            let reviewsData = [encodedReview]
            UserDefaults.standard.setValue(reviewsData, forKey: reviewStoragekey)
            
            return
        }
        reviewsData.append(encodedReview)
        UserDefaults.standard.setValue(reviewsData, forKey: reviewStoragekey)
    }
    
    func getInterest(country: String) -> Interest {
        guard let interests = UserDefaults.standard.value(forKey: interestStoragekey) as? [String: String], let rawInterest = interests[country], let interest = Interest(rawValue: rawInterest) else {
            return .none
        }
        return interest
    }
    
    func updateInterest(interest: Interest, country: String) {
        var interests = [String: String]()
        if let storedInterests = UserDefaults.standard.value(forKey: interestStoragekey) as? [String: String] {
            interests = storedInterests
        }
        interests[country] = interest.rawValue
        
        UserDefaults.standard.setValue(interests, forKey: interestStoragekey)
    }
    
    func getAllInterests() -> [String: String] {
        guard let interests = UserDefaults.standard.value(forKey: interestStoragekey) as? [String: String] else {
            return [:]
        }
        return interests
    }
}
