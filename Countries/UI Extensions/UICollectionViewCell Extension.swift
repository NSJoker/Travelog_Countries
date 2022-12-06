//
//  UICollectionViewCell Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 25/11/22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
