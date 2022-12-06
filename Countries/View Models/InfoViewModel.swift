//
//  InfoViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 26/11/22.
//

import Combine
import Foundation

class InfoViewModel {
    // MARK: Publishers
    @Published var forex: String = ""
    
    // MARK: Private Properties
    private var forexWorkItem: DispatchWorkItem?
    private let forexService: Service
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Public Properties
    let country: Country
    var capital: String {
        var capital = ""
        // Convert all the values to a single string separated bu comma
        for item in country.capital {
            capital += item
            if country.capital.last ?? "" != item {
                capital += ", "
            }
        }
        return capital
    }
    
    var region: String {
        country.subregion
    }
    
    var population: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value:country.population)) else {
            return ""
        }
        return "\(formattedNumber)"
    }
    
    var phoneCode: String {
        var code = ""
        // Convert all the values to a single string separated bu comma
        for suffix in country.idd.suffixes {
            code += country.idd.root
            code += suffix
            if suffix != country.idd.suffixes.last {
                code += ", "
            }
        }
        return code
    }
    
    var currency: String {
        country.currencies.keys.first ?? ""
    }
    
    var currencyName: String {
        guard let currencyInfo = country.currencies[currency] else { return "" }
        return currencyInfo.name
    }
    
    var currencySymbol: String {
        guard let currencyInfo = country.currencies[currency] else { return "" }
        return currencyInfo.symbol
    }
    
    var timeZone: String {
        // We need to show the UTC time zone
        for timeZone in country.timezones {
            if timeZone.range(of: "UTC") != nil {
                return timeZone
            }
        }
        
        // If we dont have the UTC time zone then return the first timezone
        if let firstTimeZone = country.timezones.first {
            return firstTimeZone
        }
        
        // If the timezones collection is empty, return empty string
        return ""
    }
    
    init(country: Country, forexService: Service) {
        self.country = country
        self.forexService = forexService
        fetchForex(for: currency)
    }
    
    deinit {
        guard let forexWorkItem = forexWorkItem else { return }
        forexWorkItem.cancel()
    }
    
    // MARK: Private Methods
    private func fetchForex(for currency: String) {
        let workItem = DispatchWorkItem {
            self.forexService.callAPI(params: currency, with: ExchangeRate.self)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure( _ ):
                        self?.forex = ""
                    default:
                        break
                    }
                } receiveValue: { [weak self] currencyInfo in
                    var format = "%0.2f"
                    if currencyInfo.rate > 1 {
                        format = "%0.0f"
                    }
                    self?.forex = String(format: format, currencyInfo.rate)
                }
                .store(in: &self.subscriptions)
        }
        forexWorkItem = workItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
    }
}
