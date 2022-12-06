//
//  HTTPMethod.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Foundation

// MARK: HTTPMethods used to make the network calls.
// Here we will only be using the GET HTTP Method to run the show

enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
    case custom(String)
    
    public var rawValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        case .custom(let method):
            return method
        }
    }
}
