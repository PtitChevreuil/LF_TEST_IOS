//
//  MapCollectionViewCell.swift
//  TheForkTest
//
//  Created by SIFFRE on 02/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit
import MapKit

class MapCollectionViewCell: UICollectionViewCell, MKMapViewDelegate {
    
    var mapView: MKMapView!
    
    var coordinates: CLLocationCoordinate2D?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mapView = MKMapView()
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        contentView.addSubview(mapView)
        
        self.contentView.clipsToBounds = true
        
        mapView.delegate = self
    }
    
    private func addRestaurantLocation() {
        
        if coordinates != nil {
            let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.005 , 0.005)
            let location:CLLocationCoordinate2D = coordinates!
            let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
            
            mapView.setRegion(theRegion, animated: true)
            
            let anotation = MKPointAnnotation()
            anotation.coordinate = location
            
            mapView.addAnnotation(anotation)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addRestaurantLocation()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.7
    }
    
    override func updateConstraints() {
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.snp.edges)
        }
        
        // according to Apple super should be called at end of method
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // will never be called
        fatalError("init(coder:) has not been implemented")
    }
}
