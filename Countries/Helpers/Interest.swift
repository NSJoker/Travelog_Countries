//
//  Interest.swift
//  Countries
//
//  Created by Chandrachudh K on 01/12/22.
//

import Foundation
import UIKit

/**
 The user's interst on a country
 */
enum Interest: String, CaseIterable {
    case interested
    case notInterested
    case alreadyVisited
    case none
    
    var description: String {
        switch self {
        case .notInterested:
            return "Not Interested to visit this nation"
        case .interested:
            return "Will visit this nation"
        case .alreadyVisited:
            return "You have already visited this nation"
        default:
            return "Update your interest in this nation"
        }
    }
    
    var optionTitle: String {
        switch self {
        case .interested:
            return "Interested"
        case .notInterested:
            return "Not Interested"
        case .alreadyVisited:
            return "Already visited"
        default:
            return ""
        }
    }
    
    var imageName: String {
        switch self {
        case .notInterested:
            return "hand.thumbsdown.fill"
        case .interested:
            return "star.fill"
        case .alreadyVisited:
            return "pin.fill"
        default:
            return "questionmark.diamond.fill"
        }
    }
    
    var imageColor: UIColor {
        switch self {
        case .notInterested:
            return UIColor.label
        case .interested:
            return UIColor.gold
        case .alreadyVisited:
            return UIColor.red
        default:
            return UIColor.systemGray
        }
    }
    
    static var listOfAllCases: [Interest] {
        var cases = Self.allCases
        cases = cases.filter({ $0 != .none })
        return cases
    }
}
