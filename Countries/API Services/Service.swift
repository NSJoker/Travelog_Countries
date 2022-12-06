//
//  Service.swift
//  Countries
//
//  Created by Chandrachudh K on 01/12/22.
//

import Combine
import Foundation

/**
 API call supporting GET HTTP Method
 */
protocol Service {
    func callAPI<Response: Decodable, Params: Codable>(params: Params, with type: Response.Type) -> AnyPublisher<Response, Error>
}
