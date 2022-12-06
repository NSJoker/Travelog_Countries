//
//  UNAndIndependanceCell.swift
//  Countries
//
//  Created by Chandrachudh K on 03/12/22.
//

import UIKit

class UNAndIndependanceCell: UITableViewCell {
    // MARK: UI Elements Outlets
    @IBOutlet weak var unMembershipBaseView: UIView!
    @IBOutlet weak var independenceBaseView: UIView!
    @IBOutlet weak var driveSideBaseView: UIView!
    @IBOutlet weak var imgUNMembership: UIImageView!
    @IBOutlet weak var imgIndependence: UIImageView!
    @IBOutlet weak var imgLeftCar: UIImageView!
    @IBOutlet weak var imgRightCar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        unMembershipBaseView.layer.cornerRadius = CORNER_RADIUS
        independenceBaseView.layer.cornerRadius = CORNER_RADIUS
        driveSideBaseView.layer.cornerRadius = CORNER_RADIUS
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        unMembershipBaseView.addShadow()
        independenceBaseView.addShadow()
        driveSideBaseView.addShadow()
    }
    
    func populate(with demographics: OtherDemographicsViewModel) {
        imgIndependence.image = demographics.imgIndependence
        imgUNMembership.image = demographics.imgUNMember
        imgLeftCar.isHidden = demographics.isRightHandDrive
        imgRightCar.isHidden = !demographics.isRightHandDrive
    }
}
