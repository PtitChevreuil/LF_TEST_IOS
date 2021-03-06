//
//  MainInfoCollectionViewCell.swift
//  TheForkTest
//
//  Created by SIFFRE on 02/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit

class MainInfoCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var addressLabel: UILabel!
    var ratingAvgLabel: UILabel!
    var feedbackLabel: UILabel!
    
    var rateString: String!
    
    private(set) var needsSetup = true
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        titleLabel = UILabel()
        titleLabel.font = UIFont (name: "HelveticaNeue", size: 24)
        titleLabel.textColor = UIColor.TFTitle()
        
        self.contentView.addSubview(titleLabel)
        
        addressLabel = UILabel()
        addressLabel.font = UIFont (name: "HelveticaNeue", size: 15)
        addressLabel.textColor = UIColor.TFGrayText()
        
        contentView.addSubview(addressLabel)
        
        ratingAvgLabel = UILabel()
        ratingAvgLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 25)
        ratingAvgLabel.textColor = UIColor.black
        
        contentView.addSubview(ratingAvgLabel)
        
        
        feedbackLabel = UILabel()
        feedbackLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
        feedbackLabel.textColor = UIColor.TFGrayText()
        
        contentView.addSubview(feedbackLabel)
        contentView.backgroundColor = UIColor.white
        
        self.setNeedsUpdateConstraints()
    }
    
    private func applyStyleToString() {
        
        if rateString.characters.count > 0 {
            let mutableString = NSMutableAttributedString(string: rateString)
            let offset = rateString.characters.count-3
            mutableString.addAttribute(NSFontAttributeName,
                                       value: UIFont(
                                        name: "HelveticaNeue-Thin",
                                        size: 12.0)!,
                                       range: NSRange(
                                        location: offset,
                                        length: 3))
            
            ratingAvgLabel.attributedText = mutableString
        } else {
            ratingAvgLabel.text = "N/A"
            ratingAvgLabel.font = UIFont(name: "HelveticaNeue", size: 25)
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyShadowTrick()
        applyStyleToString()
        self.setNeedsUpdateConstraints()
    }
    
    private func setUpConstraints() {
        if (contentView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact) {
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(8)
                make.left.equalTo(self.contentView).offset(20)
                make.right.equalTo(self.contentView).offset(20)
            }
            
            addressLabel.snp.makeConstraints { (make) in
                make.leading.equalTo(titleLabel.snp.leading)
                make.top.equalTo(titleLabel.snp.bottom).offset(5)
                make.trailing.equalTo(titleLabel.snp.trailing)
            }
            
            ratingAvgLabel.snp.makeConstraints { (make) in
                // quick workaround
                make.centerX.equalTo(contentView.snp.centerX)
                make.top.equalTo(addressLabel.snp.bottom).offset(5)
            }
            
            feedbackLabel.snp.makeConstraints { (make) in
                make.top.equalTo(ratingAvgLabel.snp.bottomMargin).offset(8)
                make.centerX.equalTo(contentView.snp.centerX)
            }
        } else {
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(8)
                make.left.equalTo(self.contentView).offset(20)
            }
            
            addressLabel.snp.makeConstraints { (make) in
                make.leading.equalTo(titleLabel.snp.leading)
                make.top.equalTo(titleLabel.snp.bottom).offset(5)
            }
            
            ratingAvgLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.top)
                make.trailing.equalTo(contentView.snp.trailing).offset(-20)
                make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(20)
            }
            
            feedbackLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(addressLabel.snp.centerY)
                make.trailing.equalTo(ratingAvgLabel.snp.trailing)
                make.leading.greaterThanOrEqualTo(addressLabel.snp.trailing).offset(20)
            }
        }
    }
    
    override func updateConstraints() {

        if needsSetup {
            setUpConstraints()
            needsSetup = false
        } else {
            deleteAllConstraints()
            setUpConstraints()
        }
        
        super.updateConstraints()
    }
    
    private func deleteAllConstraints() {
        
        titleLabel.snp.removeConstraints()
        addressLabel.snp.removeConstraints()
        feedbackLabel.snp.removeConstraints()
        ratingAvgLabel.snp.removeConstraints()
    }
    
    private func applyShadowTrick() {
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.7
        
        let shadowRect: CGRect = contentView.bounds.insetBy(dx: 0, dy: 0)
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        // will never be called
        fatalError("init(coder:) has not been implemented")
    }
}
