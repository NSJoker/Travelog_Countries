//
//  URLRequests.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Foundation

extension URLRequest {
    // MARK: Search for Country
    static func search(for text: String) -> URLRequest {
        URLRequest(components: .search(for: text))
    }
    // MARK: Fetch Forex info
    static func forex(for currency: String) -> URLRequest {
        URLRequest(components: .forex(for: currency))
    }
}
