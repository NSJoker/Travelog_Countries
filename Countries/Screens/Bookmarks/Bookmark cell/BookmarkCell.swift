//
//  BookmarkCell.swift
//  Countries
//
//  Created by Chandrachudh K on 01/12/22.
//

import UIKit

class BookmarkCell: UITableViewCell {
    // MARK: UI Elements Outlets
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblOfficialName: UILabel!
    @IBOutlet weak var lblCommonName: UILabel!
    @IBOutlet weak var lblNumberOfReviews: UILabel!
    @IBOutlet weak var imgInterest: UIImageView!
    @IBOutlet weak var lblInterest: UILabel!
    @IBOutlet weak var lcFlagBottomSpace: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        baseView.layer.cornerRadius = CORNER_RADIUS
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseView.addShadow()
    }
    
    // MARK: Public Methods
    func populateCell(country: CountryViewModel) {
        lblOfficialName.text = country.officialName
        lblCommonName.text = country.commonName
        lblInterest.text = country.interest == .none ? "You have not added any interest" : country.interest.description
        imgInterest.image = UIImage(systemName: country.interest.imageName)
        imgInterest.tintColor = country.interest.imageColor
        lblNumberOfReviews.text = "\(country.reviewsCount) \(country.reviewsCount == 1 ? "review" : "reviews")"
        
        imgFlag.setImage(url: country.flagURL, placeHolderImage: UIImage(imageLiteralResourceName: "FlagPlaceHolder")) {
            DispatchQueue.main.async { [weak self] in
                let fullSize: CGSize = self?.imgFlag.bounds.size ?? .zero
                let aspectSize = self?.imgFlag.getAspectFitSize(size: fullSize)
                self?.lcFlagBottomSpace.constant = fullSize.height - (aspectSize?.height ?? 0)
                self?.layoutIfNeeded()
            }
        }
    }
}
