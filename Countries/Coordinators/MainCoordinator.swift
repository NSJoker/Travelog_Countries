//
//  MainCoordinator.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Foundation
import UIKit

class MainCoordinator: BaseCoordinator {
    // MARK: Private Properties
    private let onBoaderStorageKey = "onBoaderStorageKey"
    
    override func start(navigationController: UINavigationController) {
        // If we have any conditions to check and show a different screen on app start we can write the logic here
        if (UserDefaults.standard.value(forKey: onBoaderStorageKey) != nil) {
            self.showHomeScreen(navigationController: navigationController)
        } else {
            UIScrollView.appearance().bounces = false
            let onBoaderCoodinator = OnBoaderCoordinator()
            store(coordinator: onBoaderCoodinator)
            onBoaderCoodinator.start(navigationController: navigationController)
            
            onBoaderCoodinator.isCompleted = { [weak self] in
                guard let strongSelf = self else { return }
                UserDefaults.standard.set(true, forKey: strongSelf.onBoaderStorageKey)
                strongSelf.showHomeScreen(navigationController: navigationController)
                strongSelf.free(coordinator: onBoaderCoodinator)
            }
        }
    }
    
    // MARK: Private Methods
    private func showHomeScreen(navigationController: UINavigationController) {
        DispatchQueue.main.async {
            UIScrollView.appearance().bounces = true
            let homeCoordinator = HomeCoordinator()
            self.store(coordinator: homeCoordinator)
            homeCoordinator.start(navigationController: navigationController)
            
            homeCoordinator.isCompleted = {
                fatalError("Home coordinator complete must not be called!")
            }
        }
    }
}
