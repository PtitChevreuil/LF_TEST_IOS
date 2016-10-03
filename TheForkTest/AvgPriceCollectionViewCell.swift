//
//  AvgPriceCollectionViewCell.swift
//  TheForkTest
//
//  Created by SIFFRE on 02/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit

class AvgPriceCollectionViewCell: UICollectionViewCell {
    
    var priceLabel: UILabel!
    var priceString: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        priceLabel = UILabel()
        priceLabel.textColor = UIColor.black
        priceLabel.font = UIFont (name: "HelveticaNeue", size: 12)
        
        contentView.addSubview(priceLabel)
        
        contentView.backgroundColor = UIColor.TFGrayBg()
        
        setUpContraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyStyleToString()
        applyShadowTrick()
    }
    
    private func setUpContraints() {
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    private func applyShadowTrick() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.7
        
        let shadowRect: CGRect = contentView.bounds.insetBy(dx: 0, dy: 0)
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }
    
    private func applyStyleToString() {
        
        
        let mutableString = NSMutableAttributedString(string: priceString)
        mutableString.addAttribute(NSFontAttributeName,
                                     value: UIFont(
                                        name: "HelveticaNeue-Bold",
                                        size: 12.0)!,
                                     range: NSRange(
                                        location: 0,
                                        length: 10))
        let length = priceString.characters.count - 40
        mutableString.addAttribute(NSFontAttributeName,
                                   value: UIFont(
                                    name: "HelveticaNeue-Bold",
                                    size: 12.0)!,
                                   range: NSRange(
                                    location: 40,
                                    length: length))
        priceLabel.attributedText = mutableString
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        // will never be called
        fatalError("init(coder:) has not been implemented")
    }
}
