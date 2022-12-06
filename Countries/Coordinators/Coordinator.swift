//
//  Coordinator.swift
//  Countries
//
//  Created by Chandrachudh K on 23/11/22.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    
    // A collection of All child coordinators created by the current coordinator
    var childCoordinators: [Coordinator] { get set }
    
    // This will inform the coordinator being started on the navigation controller it can use to push or present the viewcontroller to
    func start(navigationController: UINavigationController)
}

extension Coordinator {
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}


class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    func start(navigationController: UINavigationController) {
        fatalError("Base coordinator start must not be called!")
    }
}
