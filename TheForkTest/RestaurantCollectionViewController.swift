//
//  RestaurantCollectionViewController.swift
//  TheForkTest
//
//  Created by SIFFRE on 01/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit
import MapKit

class RestaurantCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Dependency injection
    var viewModel: RestaurantViewModel!
    
    let nbSections = 4
    
    var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = TFRestaurantLayout()
        
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        self.view.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        self.collectionView.register(MainInfoCollectionViewCell.self, forCellWithReuseIdentifier: "mainCell")
        self.collectionView.register(AvgPriceCollectionViewCell.self, forCellWithReuseIdentifier: "avgCell")
        self.collectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "mapCell")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.TFMainGreen()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.title = viewModel.resto.name
        
        self.collectionView.backgroundColor = UIColor.TFGreenBg()
        
        self.collectionView.scrollsToTop = true
        
        self.startUserActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return nbSections
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
            
            if let urlImage = viewModel.resto.pics_main {
                if let imgURL = URL(string: urlImage) {
                    DispatchQueue.global().async {
                        // DispatchQoS.QoSClass by default
                        if let data = NSData(contentsOf: imgURL) {
                            if let image = UIImage(data: data as Data) {
                                DispatchQueue.main.async(execute: {
                                    cell.imageView.image = image
                                })
                            }
                        }
                    }
                }
            }
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainInfoCollectionViewCell
            cell.titleLabel.text = viewModel.resto.name
            cell.addressLabel.text = viewModel.addressLabelText()
            cell.rateString = viewModel.ratingLabelText()
            cell.feedbackLabel.text = viewModel.feedbackLabelText()
            
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avgCell", for: indexPath) as! AvgPriceCollectionViewCell
            cell.priceString = viewModel.avgPriceLabelText()
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! MapCollectionViewCell
            
            
            let longitude = viewModel.resto.gps_long
            let latitude = viewModel.resto.gps_lat
            
            var coordinates: CLLocationCoordinate2D?
            
            if longitude != nil && latitude != nil {
                coordinates = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            }
            cell.coordinates = coordinates
            return cell
            
        default: return UICollectionViewCell()
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    // MARK: Handoff to Safari (could be handled in this project for ios devices)
    
    func startUserActivity() {
        let activity = NSUserActivity(activityType: "com.ptitchevreuil.tf.resto.view")
        if let webURL = URL(string:viewModel.resto.url) {
            activity.webpageURL = webURL
        }
        userActivity = activity
        userActivity?.becomeCurrent()
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        if let webURL = URL(string:viewModel.resto.url){
            activity.webpageURL = webURL
        }
        super.updateUserActivityState(activity)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        userActivity?.invalidate()
    }
}
