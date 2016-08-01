//
//  ViewController.swift
//  MyUnitTest
//
//  Created by hunterchen on 2016/7/20.
//  Copyright © 2016年 hunterchen. All rights reserved.
//

import UIKit
import ToastSwiftFramework
import Bluetonium
import WatchConnectivity

class ViewController: UIViewController, ManagerDelegate, WCSessionDelegate {
    lazy var btManager: Manager = {
        let manager = Manager(background: true)
        manager.delegate = self
        return manager
    }()
    @IBOutlet weak var btn_showtoast: UIButton!
    @IBOutlet weak var lb_device: UILabel!
    @IBOutlet weak var btn_connect: UIButton!
    @IBOutlet weak var lb_receive: UILabel!
    
    var session :WCSession!
    
    override func viewDidLoad() {
        btn_showtoast.backgroundColor = UIColor.clearColor()
        btn_showtoast.layer.cornerRadius = 5
        btn_showtoast.layer.borderWidth = 1
        btn_showtoast.layer.borderColor = UIColor.blackColor().CGColor
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self;
            session.activateSession()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showToast(sender: UIButton) {
        print("按鈕文字＝"+sender.currentTitle!)
        switch sender.currentTitle! {
        case "ShowToast":
            self.view.makeToast("hi See you~~~~")
        case "AlertDialog":
            let alertController = UIAlertController(title: "WOW~", message: "i am hunter", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "haha", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        case "Scan","StopScan":
            if("Scan" == sender.currentTitle){
                sender.setTitle("StopScan", forState: UIControlState.Normal)
                btManager.startScanForDevices();
                sender.titleLabel?.text = "StopScan"
            }else{
                sender.setTitle("Scan", forState: UIControlState.Normal)
                btManager.stopScanForDevices()
                sender.titleLabel?.text = "Scan"
            }
        case "Connect","Disconnect":
            if(sender.currentTitle=="Connect"){
                let device = btManager.foundDevices[0]
                btManager.connectWithDevice(device)
            }else{
                btManager.disconnectFromDevice()
                sender.setTitle("Connect", forState: UIControlState.Normal)
            }
        case "sendWatch":
            let sendmsg  = ["Value":"I am iPhone"]
            session.sendMessage(sendmsg, replyHandler: { replyMessage in
                //handle the reply
                let value = replyMessage["Value"] as? String
                //use dispatch_asynch to present immediately on screen
                dispatch_async(dispatch_get_main_queue()) {
                    self.lb_receive.text = value
                }
                }, errorHandler: {error in
                    // catch any errors here
                    print(error)
            })
        default:
            self.view.makeToast("oh~~~~")
        }
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        //handle received message
        let value = message["Value"] as? String
        dispatch_async(dispatch_get_main_queue()) {
            self.lb_receive.text = value
        }
        //send a reply
        replyHandler(["Value":"Hello, Happy Watch"])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var secondview:SecondViewController = segue.destinationViewController as! SecondViewController
        secondview.strReceive = sender!.currentTitle!!
//        presentViewController(secondview, animated: true, completion: nil)
    }
    
    // MARK: BTManagerDelegate
    
    func manager(manager: Manager, didFindDevice device: Device) {
        print("找到裝置")
        lb_device.text = device.peripheral.name
    }
    
    func manager(manager: Manager, willConnectToDevice device: Device) {
        print("準備連線裝置")
    }
    
    func manager(manager: Manager, connectedToDevice device: Device) {
        print("裝置已連線")
        if(btn_connect.currentTitle=="Connect"){
            btn_connect.setTitle("Disconnect", forState: UIControlState.Normal)
        }
    }
    
    
    func manager(manager: Manager, disconnectedFromDevice device: Device, retry: Bool) {
        print("裝置斷線")
    }
}

