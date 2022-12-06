//
//  UIView Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Foundation
import UIKit

extension UIView {
    func makeRounded() {
        self.layer.cornerRadius = self.bounds.height/2
    }
    
    func addShadowWith(shadowPath:CGPath, shadowColor:CGColor, shadowOpacity:Float, shadowRadius:CGFloat, shadowOffset:CGSize) {
        layer.masksToBounds = true
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        clipsToBounds = false
        layer.shadowPath = shadowPath
    }
    
    func addShadow() {
        addShadowWith(shadowPath: UIBezierPath(roundedRect: bounds, cornerRadius: CORNER_RADIUS).cgPath,
                      shadowColor: UIColor.shadow.cgColor,
                      shadowOpacity: 1.0,
                      shadowRadius: 2.0,
                      shadowOffset: .zero)
    }
    
    func getCornerMaskedPath(mask corners: UIRectCorner, cornerRadius: CGFloat) -> UIBezierPath {
        UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height),
                     byRoundingCorners: corners,
                     cornerRadii: CGSize(width: cornerRadius,
                                         height: cornerRadius))
    }
    
    func maskCorners(_ corners: UIRectCorner, cornerRadius: CGFloat) {
        let maskPath = getCornerMaskedPath(mask: corners, cornerRadius: cornerRadius).cgPath
        
        let frameLayer = CAShapeLayer()
        frameLayer.path = maskPath
        layer.mask = frameLayer
    }
}
