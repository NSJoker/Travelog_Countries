//
//  SearchViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Combine
import Foundation

// We use this view model to search for countries using a string
class SearchViewModel: ObservableObject {
    // MARK: Publishers
    @Published var searchResults = Countries()
    @Published var errorMessage = ""
    @Published var selectedCountry: Country?
    @Published var showBookMarks = false
    
    // MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()
    private var searchWorkItem: DispatchWorkItem?
    private let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: Public Methods
    func search(for text: String?) {
        guard let searchKey = text, canSearch(with: searchKey) else {
            return
        }
        
        // Using DispatchWorkItem here so that we can easily cancel the request when user edits search text within 1 second which is normal typing speed for mobile users
        searchWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            self.service.callAPI(params: searchKey, with: Countries.self)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        switch error {
                        case ErrorType.invalidJSON:
                            return
                        default:
                            self?.errorMessage = error.localizedDescription
                        }
                    default:
                        break
                    }
                    
                } receiveValue: { [weak self] countries in
                    self?.searchResults = countries.sorted(by: { $0.name.common < $1.name.common })
                }
                .store(in: &self.subscriptions)
        }
        searchWorkItem = workItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
    }
    
    func getCountry(at index: Int) -> Country {
        searchResults[index]
    }
    
    func didSelect(country: Country) {
        selectedCountry = country
    }
    
    func clearSearch() {
        searchResults.removeAll()
    }
    
    // MARK: Private Methods
    private func canSearch(with text: String) -> Bool {
        text.count >= 3
    }
}
