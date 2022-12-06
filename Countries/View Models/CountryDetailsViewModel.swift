//
//  CountryDetailsViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 03/12/22.
//

import AVFoundation
import Combine
import Foundation
import UIKit

enum DetailType: Int, CaseIterable {
    case demographics = 0
    case languages
    case unAndIndepence
    case noReview
}

class CountryDetailsViewModel: CountryViewModel {
    // MARK: Publishers
    @Published var didTapBack = false
    @Published var addReview = false
    @Published var refreshView = false
    
    // MARK: Public Properties
    let detailsCellTypes = DetailType.allCases
    
    var infoViewModel: InfoViewModel {
        InfoViewModel(country: country, forexService: ForexService())
    }
    
    var coatOfArmsURL: String {
        country.coatOfArms.png ?? ""
    }
    
    var langaugesViewModel: LanguageViewModel {
        LanguageViewModel(languages: country.languages)
    }
    
    var demoGraphicsViewModel: OtherDemographicsViewModel {
        OtherDemographicsViewModel(isIndependant: country.independent,
                                   isUNMember: country.unMember,
                                   isRightHandDrive: country.car.side.lowercased() != "left")
    }
    
    // MARK: Private Properties
    private let synthesizer = AVSpeechSynthesizer()
    
    override init(country: Country, reviewsManager: ReviewStoreProtocol) {
        super.init(country: country, reviewsManager: reviewsManager)
        
        self.subscribeToReviewsUpdates()
        self.subscribeToInterestUpdates()
    }
    
    // MARK: Public Methods
    func utterCountryCommonName() {
        let utterance = AVSpeechUtterance(string: commonName)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate

        synthesizer.speak(utterance)
    }
    
    func getReviewViewModel(for index: Int) -> ReviewViewModel {
        ReviewViewModel(review: reviews[index])
    }
    
    func openInMaps() {
        let googleMapsURL = country.maps.googleMaps
        guard let url = URL(string: googleMapsURL), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: Private Methods
    private func subscribeToReviewsUpdates() {
        reviewsManager.reviewsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedeReviews in
                guard let strongSelf = self else { return }
                strongSelf.reviews = strongSelf.reviewsManager.getAllReviews(of: strongSelf.country.name.official)
                strongSelf.refreshView = true
            }
            .store(in: &subscriptions)
    }
    
    private func subscribeToInterestUpdates() {
        $interest
            .sink { [weak self] newInterest in
                if newInterest != self?.interest, let countryName = self?.country.name.official {
                    self?.reviewsManager.updateInterest(interest: newInterest, country: countryName)
                }
            }
            .store(in: &subscriptions)
    }
}

