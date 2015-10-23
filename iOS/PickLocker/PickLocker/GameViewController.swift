//
//  GameViewController.swift
//  PickLocker
//
//  Created by Ainur on 09/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
    var backButton = UIButton(type: UIButtonType.Custom) as UIButton
    var LabelCode = UILabel()
    var clearCodeButton = UIButton(type: UIButtonType.Custom) as UIButton
    var sendCodeButton = UIButton(type: UIButtonType.Custom) as UIButton
    var code = NSMutableString()
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.frame = CGRectMake(0, 0, 128, 128)
        backButton.backgroundColor = UIColor.whiteColor()
        backButton.clipsToBounds = false
        //backButton.tag = tag
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
       // backButton.setImage(UIImage(named: "Excel-2013-icon-30x30"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "backButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        clearCodeButton.frame = CGRectMake(40, 240, 128, 128)
        clearCodeButton.backgroundColor = UIColor.whiteColor()
        clearCodeButton.clipsToBounds = false
        //clearCodeButton.tag = tag
        clearCodeButton.setTitle("Clear", forState: UIControlState.Normal)
        clearCodeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        clearCodeButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
        // clearCodeButton.setImage(UIImage(named: "Excel-2013-icon-30x30"), forState: UIControlState.Normal)
        clearCodeButton.addTarget(self, action: "clearCode:", forControlEvents: UIControlEvents.TouchUpInside)
       
        sendCodeButton.frame = CGRectMake(140, 240, 128, 128)
        sendCodeButton.backgroundColor = UIColor.whiteColor()
        sendCodeButton.clipsToBounds = false
        //sendCodeButton.tag = tag
        sendCodeButton.setTitle("Send", forState: UIControlState.Normal)
        sendCodeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sendCodeButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
        // sendCodeButton.setImage(UIImage(named: "Excel-2013-icon-30x30"), forState: UIControlState.Normal)
        sendCodeButton.addTarget(self, action: "sendCode:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var i:Int
        LabelCode.text = "****"
        LabelCode.frame = CGRectMake(0, 0, 128, 128)
        i = 0
        while (i < 10)
        {
            let tmp = UIButton(type: UIButtonType.Custom) as UIButton
            tmp.frame = CGRectMake(CGFloat(i) * 25, 128 , 25, 25)
            tmp.backgroundColor = UIColor.whiteColor()
            tmp.clipsToBounds = false
            tmp.tag = i
            tmp.setTitle(String(i), forState: UIControlState.Normal)
            tmp.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            tmp.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
            tmp.addTarget(self, action: "addNumber:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view.addSubview(tmp)
            
            i++
        }
     
          //   backButton.centerTextWithImage(5)
        // Do any additional setup after loading the view, typically from a nib.
       // GameNavigationBar.center.y = self.view.center.x
        //GameNavigationBar.frame.size.width = self.view.frame.size.width
        self.view.addSubview(backButton)
        self.view.addSubview(LabelCode);
        self.view.addSubview(clearCodeButton)
        self.view.addSubview(sendCodeButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNumber(sender:AnyObject) {
        if (code.length <= 3){
            code.appendString(String(sender.tag))
        }
        LabelCode.text = code as String;
        print(code)
        
    }
    
    @IBAction func clearCode(sender: AnyObject){
        LabelCode.text = "";
        code = "";
    }
    
    @IBAction func sendCode(sender: AnyObject){
        print("code sent");
    }

    
    @IBAction func backButton(sender:AnyObject) {
        
        self.performSegueWithIdentifier("back", sender: nil)
    }

}
