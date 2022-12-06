//
//  OtherDemographicsViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 03/12/22.
//

import Foundation
import UIKit

class OtherDemographicsViewModel {
    // MARK: Private Properties
    private let isIndependant: Bool
    private let isUNMember: Bool
    
    // MARK: Public Properties
    let isRightHandDrive: Bool
    var imgIndependence: UIImage? {
         UIImage(systemName: isIndependant ? "hand.thumbsup" : "hand.thumbsdown")
    }
    
    var imgUNMember: UIImage? {
         UIImage(systemName: isUNMember ? "hand.thumbsup" : "hand.thumbsdown")
    }
    
    init(isIndependant: Bool, isUNMember: Bool, isRightHandDrive: Bool) {
        self.isIndependant = isIndependant
        self.isUNMember = isUNMember
        self.isRightHandDrive = isRightHandDrive
    }
}
