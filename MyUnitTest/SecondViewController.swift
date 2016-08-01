//
//  SecondViewController.swift
//  MyUnitTest
//
//  Created by hunterchen on 2016/7/23.
//  Copyright © 2016年 hunterchen. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var btn_back: UIButton!
    var strReceive:String = ""
    
    @IBOutlet weak var lb_receivetxt: UILabel!
    @IBOutlet weak var btn_showtoast: UIButton!
    override func viewDidLoad() {
        btn_back.backgroundColor = UIColor.clearColor()
        btn_back.layer.cornerRadius = 5
        btn_back.layer.borderWidth = 1
        btn_back.layer.borderColor = UIColor.blackColor().CGColor
        super.viewDidLoad()
        self.lb_receivetxt.text = strReceive
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}