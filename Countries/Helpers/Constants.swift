//
//  Constants.swift
//  Countries
//
//  Created by Chandrachudh K on 25/11/22.
//

import Foundation
import UIKit

/**The total width of the screen**/
let SCREEN_WIDTH = UIScreen.main.bounds.width

/**Bottom safe area**/
var SAFE_BOTTOM_INSET: CGFloat {
    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
        return 50.0
    }
    return window.safeAreaInsets.bottom
}

/**Corner radius for almost all large bg views**/
let CORNER_RADIUS: CGFloat = 10.0
