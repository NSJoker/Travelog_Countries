//
//  ExchangeRate.swift
//  Countries
//
//  Created by Chandrachudh K on 04/12/22.
//

import Foundation

struct ExchangeRate: Codable {
    var date: Date = Date()
    var rate: Double = 0
    
    // We are using this way to decode the response JSON, because the key for the forex rate will always change based on the request.
    struct ExchangeRateKey: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExchangeRateKey.self)
        self.date = Date()
        self.rate = 0
        
        for key in container.allKeys {
            if key.stringValue == "date" {
                let dateStr = try container.decode(String.self, forKey: key)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.date = dateFormatter.date(from: dateStr) ?? Date()
            } else {
                self.rate = try container.decode(Double.self, forKey: key)
            }
        }
    }
}
