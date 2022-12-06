//
//  Errors.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Foundation

enum ErrorType: Error {
    /// JSON in the request was not correct
    case invalidJSON
    /// JSON in the response was not correct
    case invalidResponse
    
    case invalidRequest
    /// Indicates an error on the transport layer, e.g. not being able to connect to the server
    case transportError(Error)
    
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return  "Invalid request"
        case .invalidJSON:
            return "Invalid JSON"
        case .invalidResponse:
            return "Something went wrong with the response"
        case .transportError(let error):
            return "Unable reach server, \(error.localizedDescription)"
        }
    }
}
