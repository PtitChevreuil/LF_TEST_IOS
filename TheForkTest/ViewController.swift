//
//  ViewController.swift
//  TheForkTest
//
//  Created by SIFFRE on 01/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit
import SnapKit

let idExample = 6861

class ViewController: UIViewController {
    
    var navController: UINavigationController!
    lazy var errorMessage = UILabel()
    var iconView : UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    
    let restaurantStore = RestaurantStore()
    
    var constraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.TFMainGreen()
        
        // Icon view
        iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.image = UIImage(named: "fork")
        
        view.addSubview(iconView)
        
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(150)
            make.centerX.equalTo(self.view.snp.centerX)
            self.constraint = make.centerY.equalTo(self.view.snp.centerY).constraint
        }
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        self.view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.constraint?.update(offset: -120)
        
        view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.6, delay: 0, options: [], animations: { [unowned weakSelf = self]() -> Void in
            weakSelf.view.layoutIfNeeded()
            weakSelf.activityIndicator.startAnimating()
            
        })
        
        restaurantStore.fetchRecentRestaurant(withID: idExample) { (result) in
            switch(result) {
            case let .Success(resto) :
                OperationQueue.main.addOperation {
                    //activityIndicator.stopAnimating()
                    self.presentRestaurantView(model: resto)
                }
            case .Failure(_) :
                print("Error  ...")
                OperationQueue.main.addOperation {
                    //activityIndicator.stopAnimating()
                    self.displayErrorMsg()
                }
            }
        }

    }
    
    private func presentRestaurantView(model: RestaurantModel) {
        let nc = UINavigationController()
        let vc = RestaurantCollectionViewController()
        vc.viewModel = RestaurantViewModel(withRestaurant: model)
        nc.setViewControllers([vc], animated: true)
        
        self.present(nc, animated: true, completion: nil)
    }
    
    private func displayErrorMsg () {
        errorMessage.text = "Ooooopsss...\n L'application ne semble pas pouvoir récupérer les infos de ce restaurant. Veuillez vérifier que vous avez bien une connexion internet opérationnelle"
        errorMessage.textColor = UIColor.white
        errorMessage.textAlignment = .center
        errorMessage.numberOfLines = 0
        view.addSubview(errorMessage)
        errorMessage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(250)
            make.center.equalTo(view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

