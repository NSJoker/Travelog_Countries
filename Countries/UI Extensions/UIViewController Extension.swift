//
//  UIViewController Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 30/11/22.
//

import DeviceKit
import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String,
                   message: String,
                   actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
    
    func showActionSheet(title: String,
                         message: String,
                         actions: [UIAlertAction],
                         sourceView: UIView) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        if let presenter = alertController.popoverPresentationController {
            presenter.sourceView = sourceView;
            presenter.sourceRect = sourceView.bounds;
        }
        
        present(alertController, animated: true)
    }
}
