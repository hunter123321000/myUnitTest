//
//  InterfaceController.swift
//  bluetooth_hunter123321000 Extension
//
//  Created by hunterchen on 2016/7/27.
//  Copyright © 2016年 hunterchen. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate{

    @IBOutlet var wt_lb: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    
        if (WCSession.defaultSession().reachable) {
            // Do something
        }

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
