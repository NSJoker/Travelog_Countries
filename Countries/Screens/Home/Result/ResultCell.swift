//
//  ResultCell.swift
//  Countries
//
//  Created by Chandrachudh K on 25/11/22.
//

import UIKit
import DeviceKit

class ResultCell: UICollectionViewCell {
    // MARK: UI Elements Outlets
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgBlurFlag: UIImageView!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var lblCountry: UILabel!
    
    // MARK: Static Properties
    // These properties are here stricly regulate the size of the cell
    static let gap: CGFloat = 20
    static let offset: CGFloat = 16
    static var itemWidth: CGFloat {
        let numberOfItemsInRow = CGFloat(Device.current.isPad ? 4 : 2)
        let totalOffset = (2 * Self.offset)
        let totalGap = (Self.gap * (numberOfItemsInRow - 1))
        let itemWidth = (SCREEN_WIDTH - totalOffset - totalGap)/numberOfItemsInRow
        return itemWidth
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.cornerRadius = CORNER_RADIUS
        blurView.layer.cornerRadius = CORNER_RADIUS
        imgBlurFlag.layer.cornerRadius = CORNER_RADIUS
        
        // Add Shadow to the baseview
        baseView.addShadowWith(shadowPath: UIBezierPath(roundedRect: CGRect(x: 0,
                                                                            y: 0,
                                                                            width: Self.itemWidth-4,
                                                                            height: Self.itemWidth-4),
                                                        cornerRadius: CORNER_RADIUS).cgPath,
                               shadowColor: UIColor.shadow.cgColor,
                               shadowOpacity: 0.5,
                               shadowRadius: 2.0,
                               shadowOffset: .zero)
    }
    
    func populateView(country: Country) {
        let url = country.flags.png ?? ""
        imgBlurFlag.setImage(url: url) {
        }
        imgFlag.setImage(url: url) {
        }
        
        lblCountry.text = country.name.common
    }
}
