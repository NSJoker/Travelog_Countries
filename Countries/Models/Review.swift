//
//  Review.swift
//  Countries
//
//  Created by Chandrachudh K on 28/11/22.
//

import Foundation

struct Review: Codable {
    let id: UUID
    let headline: String
    let review: String
    let createdDate: TimeInterval
    let countryName: String // Official name of the country
    
    init(id: UUID = UUID(), headline: String, review: String, createdDate: TimeInterval, countryName: String) {
        self.id = id
        self.review = review
        self.createdDate = createdDate
        self.countryName = countryName
        self.headline = headline
    }
}
