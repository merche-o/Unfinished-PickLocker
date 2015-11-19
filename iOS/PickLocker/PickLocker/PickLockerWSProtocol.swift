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
    func signInDone(retCode:Int, resp:[UserData], token:String)
    func getGamesDone(retCode:Int, resp:[GameData])
    func getMyGamesDone(retCode:Int, resp:[GameData])
    func postMyGamesDone(retCode: Int, resp:[GameData])
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
    
    public func getMyGames(userid:Int) {
        let connector = GameConnector(caller: caller)
        connector.getMyGames(userid)
    }
    
    public func getWaitingGames(userid:Int) {
        let connector = GameConnector(
        caller: caller)
        connector.getWaitingGames(userid)
    }
    
    public func postNewGame(user:UserData) {
        let connector = GameConnector(caller:caller)
        connector.postNewGame(user)
    }
    

}