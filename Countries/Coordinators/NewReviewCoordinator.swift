//
//  NewReviewCoordinator.swift
//  Countries
//
//  Created by Chandrachudh K on 28/11/22.
//

import Combine
import DeviceKit
import Foundation
import UIKit

class NewReviewCoordinator: BaseCoordinator {    
    // MARK: Private Properties
    private let countryName: String
    private let newReviewViewModel: NewReviewViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(countryName: String) {
        self.countryName = countryName
        self.newReviewViewModel = NewReviewViewModel(countryName: countryName, reviewsManager: ReviewUserDefaultStorage.shared)
    }
    
    override func start(navigationController: UINavigationController) {
        let newReviewController = NewReviewViewController(newReviewViewModel: newReviewViewModel)
        
        newReviewViewModel.$dismiss
            .receive(on: DispatchQueue.main)
            .sink { [weak self] didDismiss in
                if didDismiss {
                    navigationController.dismiss(animated: true)
                    guard let strongSelf = self else { return }
                    strongSelf.isCompleted?()
                }
            }
            .store(in: &subscriptions)
        
        if Device.current.isPad {
            newReviewController.modalPresentationStyle = .formSheet
            newReviewController.preferredContentSize = CGSize(width: SCREEN_WIDTH/2, height: 440)
        }
        
        navigationController.present(newReviewController, animated: true)
    }
}
