//
//  ReviewStore.swift
//  Countries
//
//  Created by Chandrachudh K on 28/11/22.
//

import Combine
import Foundation

/**
 Protocol to mange the reviews storage for every country
 */
protocol ReviewStoreProtocol: AnyObject {
    var reviews: [Review] { get set }
    var reviewsPublisher: Published<[Review]>.Publisher { get }
    
    func save(review: Review)
    func getAllReviews(of country: String) -> [Review]
    func delete(review: Review)
    func getAllReviews() -> [Review]
    
    func getInterest(country: String) -> Interest
    func updateInterest(interest: Interest, country: String)
    func getAllInterests() -> [String: String]
}
