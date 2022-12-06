//
//  AddReviewCell.swift
//  Countries
//
//  Created by Chandrachudh K on 28/11/22.
//

import UIKit

class AddReviewCell: UITableViewCell {
    // MARK: UI Elements Outlets
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let message = "Oops! Looks like you have not yet added any review for this nation.\n"
        let tapStr = "Tap to add a review"
        let finalStr = message + tapStr
        let messageRange = NSRange(location: 0, length: message.count)
        let tapStrRange = NSRange(location: message.count, length: tapStr.count)
        let attrStr = NSMutableAttributedString(string: finalStr)
        attrStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .light), range: messageRange)
        attrStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .bold), range: tapStrRange)
        attrStr.addAttribute(.foregroundColor, value: UIColor.link.cgColor, range: tapStrRange)
        lblMessage.attributedText = attrStr
    }
}
