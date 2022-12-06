//
//  ReviewCell.swift
//  Countries
//
//  Created by Chandrachudh K on 26/11/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    // MARK: UI Element Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseView.layer.cornerRadius = CORNER_RADIUS
    }
    
    func populate(with review: ReviewViewModel) {
        lblTitle.isEnabled = review.title.isEmpty
        lblTitle.text = review.title
        lblReview.text = review.userReview
        lblCreatedDate.text = review.createdDate
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.addShadow()
    }
}
