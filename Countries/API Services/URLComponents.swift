//
//  URLComponents.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Foundation

extension URLComponents {
    // MARK: Search for country
    // Search url example: https://restcountries.com/v3.1/name/peru
    static func search(for text: String) -> URLComponents {
        URLComponents(host: "restcountries.com", path: "/v3.1/name/\(text)")
    }
    
    // MARK: Forex Info
    // fetching foex info example:https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/usd/inr.json
    static func forex(for currency: String) -> URLComponents {
        URLComponents(host: "cdn.jsdelivr.net", path: "/gh/fawazahmed0/currency-api@1/latest/currencies/usd/\(currency).json")
    }
}
