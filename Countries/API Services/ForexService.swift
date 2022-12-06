//
//  ForexService.swift
//  Countries
//
//  Created by Chandrachudh K on 04/12/22.
//

import Combine
import Foundation

/**
 Custom API Service for fetching Forex Info
 */
class ForexService: Service {
    // MARK: Fetch Forex Info
    func callAPI<Response, Params>(params: Params, with type: Response.Type) -> AnyPublisher<Response, Error> where Response : Decodable, Params : Decodable, Params : Encodable {
        if let currency = params as? String {
            return URLSession.shared.fetch(for: .forex(for: currency.lowercased()), with: type)
        }
        return AnyPublisher(
            Fail<Response, Error>(error: ErrorType.invalidRequest)
        )
    }
}
