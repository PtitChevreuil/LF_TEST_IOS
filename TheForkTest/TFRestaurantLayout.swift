//
//  TFRestaurantLayout.swift
//  TheForkTest
//
//  Created by SIFFRE on 02/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit

class TFRestaurantLayout: UICollectionViewFlowLayout {
    
    var imageHeight: CGFloat = 200
    var mainHeight: CGFloat = 120

    var layoutAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var collectionViewWidth: CGFloat = 0
    
    var leftMargin: CGFloat = 0
    var rightMargin: CGFloat = 0
    var lineSpacing: CGFloat = 0
    var sectionSpacing: CGFloat = 0
    
    let numberOfSections = 4
    
    let sectionImage = 0
    let sectionMainInfoResto = 1
    let sectionAvgPrice = 2
    let sectionMap = 3
    
    var currY: CGFloat = 0
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView else { return CGSize(width: UIScreen.main.bounds.width, height: currY)}
        return CGSize(width: collectionView.frame.width, height: currY)
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    private func setup() {
        // setting up some inherited values
        
        minimumInteritemSpacing = lineSpacing
        minimumLineSpacing = lineSpacing
        scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionViewWidth = UIScreen.main.bounds.width
        if let collectionView = collectionView {
            collectionViewWidth = collectionView.frame.size.width
        }
        
        headerReferenceSize = CGSize(width: collectionViewWidth, height: 50)
    }
    
    private func setUpImageHeight() {
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad && collectionView?.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular) {
            imageHeight = 300
            mainHeight = 80
        } else {
            imageHeight = 200
            mainHeight = 120
        }
    }
    
    private func getMargin() -> CGFloat {
        
        var margin: CGFloat = 0
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad && collectionView!.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular) {
            if (UIDevice.current.orientation.isLandscape) {
                margin = 200
            } else {
                margin = 75
            }
        } else {
            // iphone or ipad multitasking
            margin = 0
        }

        return margin
    }
    
    override func prepare() {
        
        currY = 0
        setup()
        setUpImageHeight()
        
        for i in 0 ..< numberOfSections {
            
            if let collectionView = self.collectionView {
                
                for j in 0 ..< collectionView.numberOfItems(inSection: i) {
                    
                    let indexPath = IndexPath(row: j, section: i)
                    
                    let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                    itemAttributes.frame = frameForItemAtIndexPath(indexPath: indexPath as NSIndexPath)
                    
                    currY += itemAttributes.frame.size.height
                    
                    if indexPath.section == 0 && UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
                        currY -= 100
                    }
                    
                    layoutAttributes[indexPath] = itemAttributes
                }
            }
        }
    }
    
    private func frameForItemAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        
        let margin = getMargin()
        if (indexPath.section == sectionImage) {
            return  CGRect(x: 0, y: currY, width: collectionViewWidth, height: imageHeight)
        } else if (indexPath.section == sectionMainInfoResto) {
            return CGRect(x: margin, y: currY, width: collectionViewWidth - 2*margin, height: mainHeight)
        } else if (indexPath.section == sectionAvgPrice) {
            return CGRect(x: margin, y: currY, width: collectionViewWidth - 2*margin, height: 60)
        } else if (indexPath.section == sectionMap) {
            return CGRect(x: margin, y: currY, width: collectionViewWidth - 2*margin, height: 300)
        }
        return CGRect()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        
        for (_, attributes) in layoutAttributes {
            if rect.intersects(attributes.frame) {
                allAttributes.append(attributes)
            }
        }
        
        return allAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath]
    }
    
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        return true
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return !__CGSizeEqualToSize(newBounds.size, self.collectionView!.frame.size)
    }

}
