//
//  UITableViewCell Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 26/11/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
