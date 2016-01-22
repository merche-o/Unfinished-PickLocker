//
//  SetCodeViewController.swift
//  PickLocker
//
//  Created by Ainur on 18/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import Alamofire
import UIKit

class NewGameViewController: UIViewController {
    var backButton = UIButton(type: UIButtonType.Custom) as UIButton
    var LabelCode = UILabel()
    var titleLabel = UILabel()
    var clearCodeButton = UIButton(type: UIButtonType.Custom) as UIButton
    var sendCodeButton = UIButton(type: UIButtonType.Custom) as UIButton
    var code = NSMutableString()
    override func viewDidLoad() {
        super.viewDidLoad()
        //dans le cas d'une newGame
        
        //check si on peu rejoindre une game
        requestManager.getWaitingGames((caller.user._id?.integerValue)!)
        // appels pour creer une game
       
        
        //checker si le code est deja set ou pas ou est une partie qui existe deja lancer
        if (code.length == 4){
            self.performSegueWithIdentifier("Play", sender: nil);
        }

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
        
        
        LabelCode.text = "****"
        LabelCode.frame = CGRectMake(0, 0, 128, 128)
        titleLabel.text = "New game"
        titleLabel.frame = CGRectMake(150,0, 128, 128)
        var i:Int
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
        self.view.addSubview(LabelCode)
        self.view.addSubview(titleLabel)
        self.view.addSubview(clearCodeButton)
        self.view.addSubview(sendCodeButton)
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
        if (code.length == 4) {
            print(code)
            if (caller.currentGame._player1?._userId == caller.user._id) {
                print("ici?")
                requestManager.setPlayerCode(code as String, playerId: caller.currentGame._player1!._id!.longLongValue)
            }
            else {
                print("la?")
                requestManager.postPlayerInGame(code as String, userId: (caller.user._id?.longLongValue)!, gameID: (caller.currentGame._id?.longLongValue)!)
            
            }
            self.performSegueWithIdentifier("Play", sender: nil)
        }
    }
    
    
    @IBAction func backButton(sender:AnyObject) {
        
        self.performSegueWithIdentifier("back", sender: nil)
    }

    
}

