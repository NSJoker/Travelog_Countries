//
//  UITableView Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 26/11/22.
//

import Foundation
import UIKit

extension UITableView {
    // A function that will register the correnponding nib of a tableview cell to the tableview.
    func registerCellWithXib(reuseIdentifier: String) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // A function that will register the section header and footer views that we created using nib files to the tableview
    func registerHeaderFooterView(reuseIdentifier: String) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
}
