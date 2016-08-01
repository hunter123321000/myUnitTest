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
    @IBOutlet var btn_sendmsg: WKInterfaceButton!
    var session : WCSession!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    
        if (WCSession.defaultSession().reachable) {
            // Do something
        }
    }
    

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        //handle received message
        let value = message["Value"] as? String
        //use this to present immediately on the screen
        dispatch_async(dispatch_get_main_queue()) {
            self.wt_lb.setText(value)
        }
        //send a reply
//        replyHandler(["Value":"Yes, sure"])
    }
    
    @IBAction func sendMessage() {
        let messageToSend = ["Value":"Hello happy iPhone"]
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
            //handle and present the message on screen
            let value = replyMessage["Value"] as? String
            self.wt_lb.setText(value)
            }, errorHandler: {error in
                // catch any errors here
                print(error)
        })
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
