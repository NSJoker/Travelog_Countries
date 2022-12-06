//
//  UIImageView Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 25/11/22.
//

import Foundation
import SDWebImage
/**
 Extension to properly utilize the SDWebimage module, with smooth UI loading experience
 */
extension UIImageView {
    static private let animationDuration:Double = 0.25
    
    func setImage(url:String, placeHolderImage:UIImage? = nil, complete: @escaping ()->()?) {
        self.image = placeHolderImage
        if url.count < 1 {
            image = placeHolderImage
            return
        }
        
        clipsToBounds = true
        layer.shouldRasterize = true
        if SDWebImageManager.shared.cacheKey(for: URL(string: url)) != nil {
            self.layer.shouldRasterize = false
            UIView.animate(withDuration: UIImageView.animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.alpha = 0.0
            }) { (finished) in
                self.sd_setImage(with: URL(string: url))
                UIView.animate(withDuration: UIImageView.animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                    self.alpha = 1.0
                }) { (finished) in
                    complete()
                }
            }
        }
        else {
            self.sd_setImage(with: URL(string: url), placeholderImage:placeHolderImage, options: [.avoidAutoSetImage,.highPriority,.retryFailed,.delayPlaceholder], completed: { (image, error, cacheType, url) in
                if error == nil {
                    DispatchQueue.main.async {
                        self.layer.shouldRasterize = false
                        UIView.animate(withDuration: UIImageView.animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                            self.alpha = 0.0
                        }) { (finished) in
                            self.image = image
                            
                            UIView.animate(withDuration: UIImageView.animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                                self.alpha = 1.0
                            }) { (finished) in
                                complete()
                            }
                        }
                    }
                }
                else {
                    self.layer.shouldRasterize = false
                }
            })
        }
    }
    
    func getAspectFitSize(size: CGSize) -> CGSize {
        guard let imageSize = self.image?.size else {
            return size
        }
        let finalWidth = size.width
        let finalHeight = (imageSize.height * size.height)/imageSize.width
        return CGSize(width: finalWidth, height: finalHeight)
    }
}
