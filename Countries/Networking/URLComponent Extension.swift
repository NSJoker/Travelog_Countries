//
//  URLComponent Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Foundation

extension URLComponents {
    
    /// Generate URLComponent object with provided details
    /// - Parameters:
    ///   - scheme: Most of the time this is https, if not feel free to provide a different one
    ///   - host: Provide the domain/host name for the API
    ///   - path: The URL path for the API
    ///   - queryItems: provide the request body here
    /// - Returns:
    /// URLComponent Object
    init(scheme: String = "https",
         host: String,
         path: String,
         queryItems: [URLQueryItem]? = nil) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        self = components
    }
}
