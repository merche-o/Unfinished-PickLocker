//
//  PickLockerWSProtocol.swift
//  PickLocker
//
//  Created by Ainur on 18/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import Foundation

public protocol PickLockerWSProtocol {
    func getToken()->String
    func signInDone(retCode:Int, resp:[UserData])
    
    
}

public class PicklockerConnector {
    
    var caller:PickLockerWSProtocol
    
    public init(caller:PickLockerWSProtocol) {
        self.caller=caller
    }
    
    public func signIn(username:String, email: String, passwd:String) {
        let connector = SigninConnector(caller:caller)
        connector.signIn(username, password: passwd, email: email)
    }
    
    public func getGames() {
        
     //   let connector = GamesConnector(caller: caller)
   //     connector.getGames()
    }

}