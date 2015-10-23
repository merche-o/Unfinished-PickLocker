//
//  RequestWS.swift
//  PickLocker
//
//  Created by Ainur on 22/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import Foundation

class RequestWS : PickLockerWSProtocol {
    var token:String = ""
    var user = UserData()
    func getToken()->String {
        return self.token
    }
    
    func setToken(token:String) {
     self.token = token
    }
    
    func signInDone(retCode:Int, resp:[UserData]) {
        var i = 0
        user = resp[0]
        while (i < resp.count) {
            print(user._userName)
            i++;
        }
    }
    

}