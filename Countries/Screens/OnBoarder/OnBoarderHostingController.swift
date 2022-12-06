//
//  OnBoarderHostingController.swift
//  Countries
//
//  Created by Chandrachudh K on 04/12/22.
//

import Foundation
import SwiftUI

/**
 Since we are using SwiftUI for a single screen in the app for demonstraing the developer's SwiftUI skill, we need UIHostingController to bridge SwiftUI with UIKit
 */
class OnBoarderHostingController: UIHostingController<OnboarderView> {
    convenience init(onBoaderViewModel: OnBoaderViewModel) {
        self.init(rootView: OnboarderView(onBoaderViewModel: onBoaderViewModel))
    }
}
