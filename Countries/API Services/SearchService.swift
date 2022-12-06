//
//  SearchService.swift
//  Countries
//
//  Created by Chandrachudh K on 01/12/22.
//

import Combine
import Foundation
/**
 Custom API Service for searching Countries
 */
class SearchService: Service {
    // MARK: Search Country
    func callAPI<Response, Params>(params: Params, with type: Response.Type) -> AnyPublisher<Response, Error> where Response : Decodable, Params : Decodable {
        if let searchKey = params as? String {
            return URLSession.shared.fetch(for: .search(for: searchKey.lowercased()), with: type)
        }
        return AnyPublisher(
            Fail<Response, Error>(error: ErrorType.invalidRequest)
        )
    }
}
