//
//  URLSession Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Combine
import Foundation

extension URLSession {
    // MARK: Fetch data with publisher
    func fetch<Response: Decodable>(for request: URLRequest, with type: Response.Type) -> AnyPublisher<Response, Error> {
        dataTaskPublisher(for: request)
            .mapError { error -> Error in
                return ErrorType.transportError(error)
            }
            .map(\.data)
            .decode(type: type, decoder: JSONDecoder())
            .mapError({ _ in
                return ErrorType.invalidJSON
            })
            .eraseToAnyPublisher()
        
    }
}
