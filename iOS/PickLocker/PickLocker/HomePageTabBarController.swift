//
//  HomePageTabBarController.swift
//  PickLocker
//
//  Created by Ainur on 08/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import UIKit

let caller=RequestWS()

let requestManager=PicklockerConnector(caller: caller)

class HomePageTabBarController: UITabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager.signIn("test", email: "o.mercher24@gmail.com", passwd: "test")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}