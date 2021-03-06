//
//  InterfaceController.swift
//  TheForkTestWatch Extension
//
//  Created by SIFFRE on 05/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            WKInterfaceController.reloadRootControllers(withNames: ["restoController"], contexts: nil)
        })
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
