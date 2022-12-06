//
//  BookmarksViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 01/12/22.
//

import Combine
import Foundation

class BookmarksViewModel {
    // MARK: Publishers
    @Published var dismiss = false
    @Published var selectedFilter: BookmarkFilter = .none
    @Published var filteredCountries = [CountryViewModel]()
    @Published var selectedCountry: CountryViewModel?
    
    // MARK: Private Properties
    private let allReviewedCountries: [String]
    private let service: Service
    private let reviewStore: ReviewStoreProtocol
    private var subscriptions = Set<AnyCancellable>()
    private let dispatchGroup = DispatchGroup()
    private var countries = [CountryViewModel]()
    private var searchText: String = ""
    
    // MARK: Public Properties
    var bookmarksCount: Int {
        filteredCountries.count
    }
    
    var filterDescription: String {
        filteredCountries.count != 0 ? selectedFilter.filterDescription : selectedFilter.filterNoResultDescription
    }
    
    init(service:Service, reviewStore: ReviewStoreProtocol) {
        self.service = service
        self.reviewStore = reviewStore
        let allCountries = reviewStore.getAllReviews().map({ $0.countryName })
        let allInterestCountries = reviewStore.getAllInterests().keys
        let allCountriesSet = Set(allCountries + allInterestCountries)
        self.allReviewedCountries = Array(allCountriesSet)
        
        self.subscribeToFilter()
        self.fetchAllCountries()
    }
    
    // MARK: Public Methods
    func search(for text: String?) {
        searchText = text ?? ""
        filterCountries()
    }
    
    // MARK: Private Methods
    private func fetchAllCountries() {
        for reviewedCountry in allReviewedCountries {
            dispatchGroup.enter()
            self.service.callAPI(params: reviewedCountry, with: Countries.self)
                .sink { [weak self] _ in
                    self?.dispatchGroup.leave()
                } receiveValue: { [weak self] resultCountries in
                    guard let strongSelf = self else { return }
                    strongSelf.countries.append(contentsOf: resultCountries.filter({ $0.name.official == reviewedCountry }).map({ CountryViewModel(country: $0, reviewsManager: strongSelf.reviewStore) }))
                }
                .store(in: &subscriptions)
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            DispatchQueue.main.async {
                self?.filterCountries()
            }
        }
    }
    
    private func subscribeToFilter() {
        $selectedFilter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newFilter in
                guard let strongSelf = self else { return }
                strongSelf.filterCountries()
            }
            .store(in: &subscriptions)
    }
    
    private func filterCountries() {
        switch selectedFilter {
        case .hasReview:
            filteredCountries = countries.filter({
                self.reviewStore.getAllReviews(of: $0.officialName).count != 0 && $0.shouldShowInSearch(searchText: searchText)
            })
        case .interested:
            filteredCountries = countries.filter({
                $0.interest == .interested && $0.shouldShowInSearch(searchText: searchText)
                
            })
        case .notInterested:
            filteredCountries = countries.filter({
                $0.interest == .notInterested && $0.shouldShowInSearch(searchText: searchText)
            })
        case .alreadyVisited:
            filteredCountries = countries.filter({
                $0.interest == .alreadyVisited && $0.shouldShowInSearch(searchText: searchText)
            })
        default:
            filteredCountries = countries.filter({
                $0.shouldShowInSearch(searchText: searchText)
            })
        }
    }
}
