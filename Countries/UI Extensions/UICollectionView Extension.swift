//
//  UICollectionView Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 25/11/22.
//

import Foundation
import UIKit

extension UICollectionView {
    // A function that will register the correnponding nib of a collectionview cell to the collectionview.
    func registerCellWithXib(reuseIdentifier: String) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
