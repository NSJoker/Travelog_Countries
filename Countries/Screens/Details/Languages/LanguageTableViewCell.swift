//
//  LanguageTableViewCell.swift
//  Countries
//
//  Created by Chandrachudh K on 03/12/22.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    // MARK: UI Elements Outlets
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblLanguages: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseView.layer.cornerRadius = CORNER_RADIUS
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseView.addShadow()
    }
    
    func populate(languages: LanguageViewModel) {
        lblLanguages.text = languages.allLanguages
    }
    
}
