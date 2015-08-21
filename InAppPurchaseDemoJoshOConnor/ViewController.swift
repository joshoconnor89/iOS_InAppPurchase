//
//  ViewController.swift
//  InAppPurchaseDemoJoshOConnor
//
//  Created by Joshua O'Connor on 5/20/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var level2Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appdelegate = UIApplication.sharedApplication().delegate
            as! AppDelegate
        
        appdelegate.homeViewController = self
    }
    
    func enableLevel2() {
        level2Button.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

