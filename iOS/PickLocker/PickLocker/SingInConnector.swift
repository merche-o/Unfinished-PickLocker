//
//  SingInConnector.swift
//  PickLocker
//
//  Created by Ainur on 22/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import Foundation


class SigninConnector: WSConnector {
    
    var idRestaurant:Int64 = 0
    var username:String = ""
    var password:String = ""
    var email:String = ""
    override init(caller: PickLockerWSProtocol) {
        super.init(caller: caller)
    }
    
    override func formatRequest(req:Method) {
        let response : Dictionary<String, AnyObject> = [
            "username" : self.username,
            "password": self.password,
            "email": self.email
        ]
        self.params = response
    }
    
    override func parseResponse(retCode: Int, response: AnyObject) {
        //doit parser response
        super.parseResponse(retCode, response: response)
        var responseParsed = [UserData] ()

        // parsing
        var i:Int
        i = 0
       
        //tmp._idPhoto =
        while (i < response.count)
        {
            self.token = (response[i].valueForKeyPath("token") as? String)!
            //tmp._idPhoto = parseResource(response[i].valueForKeyPath("id_photo")!)
            responseParsed.append(parseUser(response[i].valueForKeyPath("user")!))
            i++;
        }
        
        caller.signInDone(retCode, resp: responseParsed)
    }
    
    func parseUser(response:AnyObject)->UserData {
        let tmp = UserData()
        tmp._id = response.valueForKeyPath("id") as? NSNumber
        tmp._userName = response.valueForKeyPath("username") as? String
        tmp._firstName = response.valueForKeyPath("firstName") as? String
        tmp._lastName = response.valueForKeyPath("lastName") as? String
        tmp._email = response.valueForKeyPath("email") as? String
        return tmp;
    }
    
    func signIn(username:String, password:String, email:String) {
        
        self.username = username
        self.password = password
        self.email = email
        self.apiAdress += "auth/signin/"
        self.httpMeth = Method.POST
        sendRequest(caller, req: self.httpMeth, isTokenRequired: false)
    }
    override func  handleError(retCode:Int) {
        super.handleError(retCode)
        self.caller.signInDone(retCode, resp: [UserData]())
    }
    
    
}
