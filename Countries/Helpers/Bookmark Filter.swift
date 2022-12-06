//
//  Bookmark Filter.swift
//  Countries
//
//  Created by Chandrachudh K on 04/12/22.
//

import Foundation

enum BookmarkFilter: CaseIterable {
    case none
    case hasReview
    case interested
    case notInterested
    case alreadyVisited
    
    var optionTitle: String {
        switch self {
        case .hasReview:
            return "Has a review"
        case .interested:
            return "Marked as interested"
        case .notInterested:
            return "Marked as not interested"
        case .alreadyVisited:
            return "Already visited"
        default:
            return "All"
        }
    }
    
    var filterDescription: String {
        switch self {
        case .hasReview:
            return "Showing all countries that has a review"
        case .interested:
            return "Showing all countries that you are interested"
        case .notInterested:
            return "Showing all countries that you are not interested"
        case .alreadyVisited:
            return "Showing all countries that you have already visited"
        default:
            return "Showing all countries that has a review or a bookmark"
        }
    }
    
    var filterNoResultDescription: String {
        switch self {
        case .hasReview:
            return "No reviews found"
        case .interested:
            return "No interested countries found"
        case .notInterested:
            return "No not interested countires found"
        case .alreadyVisited:
            return "No visited countries found"
        default:
            return "No bookmarked ot reviewd countries found"
        }
    }
}
