//
//  DataView.swift
//  Countries
//
//  Created by Chandrachudh K on 26/11/22.
//

import UIKit

@IBDesignable class DataView: UIView {
    @IBInspectable var title: String = "" {
        didSet {
            setupUI()
        }
    }
    
    @IBInspectable var value: String = "" {
        didSet {
            setupUI()
        }
    }
    
    private let lblTitle = UILabel(frame: .zero)
    private let lblValue = UILabel(frame: .zero)
    
    private func setupUI() {
        // Setup Title label
        if lblTitle.superview == nil {
            addSubview(lblTitle)
        }
        lblTitle.text = title
        lblTitle.textAlignment = .center
        lblTitle.font = .systemFont(ofSize: 16, weight: .semibold)
        lblTitle.textColor = .label
        
        // Setup value label
        if lblValue.superview == nil {
            addSubview(lblValue)
        }
        lblValue.text = value
        lblValue.textAlignment = .center
        lblValue.font = .systemFont(ofSize: 16, weight: .regular)
        lblValue.textColor = .link
        lblValue.numberOfLines = 2
        
        clipsToBounds = false
        layer.cornerRadius = CORNER_RADIUS
        backgroundColor = .BGColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxWidth = bounds.width - 10
        let titleSize = lblTitle.sizeThatFits(CGSize(width: maxWidth, height: .infinity))
        let valueSize = lblValue.sizeThatFits(CGSize(width: maxWidth, height: .infinity))
        
        let gap: CGFloat = 5
        let totalHeight = titleSize.height + valueSize.height + gap
        var y = (bounds.height - totalHeight)/2
        
        lblTitle.frame = CGRect(x: 5, y: y, width: maxWidth, height: titleSize.height)
        y += titleSize.height
        y += gap
        lblValue.frame = CGRect(x: 5, y: y, width: maxWidth, height: valueSize.height)
        
        addShadow()
    }
}
