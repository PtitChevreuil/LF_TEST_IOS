//
//  ImagesCollectionViewCell.swift
//  TheForkTest
//
//  Created by SIFFRE on 02/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    // Should be a pageviewcontroller if we want to stick 
    // to the existing design
    var imageView : UIImageView!
    
    private(set) var needsSetup = true
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.black
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFill
        contentView.clipsToBounds = true
        
        self.contentView.addSubview(imageView)
    }
    
    private func setUpConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func updateConstraints() {
        
        if needsSetup {
            setUpConstraints()
            needsSetup = false
        }
        
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // will never be called
        fatalError("init(coder:) has not been implemented")
    }
}
