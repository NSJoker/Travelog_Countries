//
//  OnBoaderViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 04/12/22.
//

import Combine
import Foundation

class OnBoaderViewModel: ObservableObject {
    // MARK: Publishers
    @Published var dismiss = false
    
    // MARK: Public Properties
    var onBoardingSteps: [OnboardingStep] = [
        .init(image: "Travel", title: "See the world!", description: "Are you a travel enthusiast?"),
//        .init(image: "Discover", title: "Discover", description: "We can help you know more about the place that you are traveling to."),
        .init(image: "Globe", title: "You are going places!", description: "Lots of places to go, one place to save your views about them!"),
        .init(image: "Search", title: "Discover your right places with us", description: "Look for the information on any country, even with abstract search keys"),
        .init(image: "Dollar", title: "Currency", description: "Get forex rates of the selected nations currency with USD!"),
        .init(image: "Review", title: "Reviews", description: "Add reviews to countries of interest, create a collection of reviews and notes"),
        .init(image: "Bookmark", title: "Bookmarks", description: "Bookmark countries of interest by adding a review to it or explicitly setting them from the country's details page")
    ]
    
    // MARK: Public Methods
    func getStarted() {
        dismiss = true
    }
}
