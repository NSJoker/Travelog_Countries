//
//  InfoCell.swift
//  Countries
//
//  Created by Chandrachudh K on 26/11/22.
//

import Combine
import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    
    // MARK: Currency View IBOutlets
    @IBOutlet weak var currencyBaseView: UIView!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblForex: UILabel!
    
    // MARK: Other Data View IBOutlets
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var timeDataView: DataView!
    @IBOutlet weak var populationDataView: DataView!
    @IBOutlet weak var regionDataView: DataView!
    @IBOutlet weak var phoneCodeDataView: DataView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseView.layer.cornerRadius = CORNER_RADIUS
        currencyBaseView.layer.cornerRadius = CORNER_RADIUS
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseView.addShadowWith(shadowPath: UIBezierPath(roundedRect: CGRect(x: 0,
                                                                            y: 0,
                                                                            width: SCREEN_WIDTH-20,
                                                                            height: baseView.bounds.height), cornerRadius: CORNER_RADIUS).cgPath,
                               shadowColor: UIColor.shadow.cgColor,
                               shadowOpacity: 0.5,
                               shadowRadius: 2.0,
                               shadowOffset: .zero)

        currencyBaseView.addShadow()
    }
    
    func populate(with info: InfoViewModel) {
        
        // Capital info
        let prefixString = "Capital: "
        let prefixRange = NSRange(location: 0, length: prefixString.count)
        let finalString = prefixString + info.capital
        let capitalStringRange = NSRange(location: prefixString.count, length: info.capital.count)
        let attributtesString = NSMutableAttributedString(string: finalString)

        attributtesString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: prefixRange)
        attributtesString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .regular), range: capitalStringRange)
        lblCapital.attributedText = attributtesString
        
        
        // Currency Info
        lblCurrency.text = info.currency
        lblCurrencyName.text = info.currencyName
        lblSymbol.text = info.currencySymbol
        lblForex.text = "1 USD = - " + info.currency
        
        timeDataView.value = info.timeZone
        populationDataView.value = info.population
        regionDataView.value = info.region
        phoneCodeDataView.value = info.phoneCode
        
        info.$forex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let strongSelf = self, !newValue.isEmpty else { return }
                strongSelf.lblForex.text = "1 USD = \(newValue) " + info.currency
            }
            .store(in: &subscriptions)
    }
}
