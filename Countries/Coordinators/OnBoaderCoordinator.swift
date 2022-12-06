//
//  OnBoaderCoordinator.swift
//  Countries
//
//  Created by Chandrachudh K on 04/12/22.
//

import Combine
import Foundation
import UIKit

class OnBoaderCoordinator: BaseCoordinator {
    // MARK: Private Properties
    private let onBoaderViewModel = OnBoaderViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func start(navigationController: UINavigationController) {
        
        onBoaderViewModel.$dismiss
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldDismiss in
                if shouldDismiss {
                    navigationController.popViewController(animated: true)
                    self?.isCompleted?()
                }
            }
            .store(in: &subscriptions)
        
        let onBoaderViewController = OnBoarderHostingController(onBoaderViewModel: onBoaderViewModel)
        navigationController.pushViewController(onBoaderViewController, animated: true)
    }
}
