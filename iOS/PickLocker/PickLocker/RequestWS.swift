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
    var myGames = [GameData]()
    var currentGame = GameData()
    func getToken()->String {
        return self.token
    }
    
    func setToken(token:String) {
     self.token = token
    }
    
    func signInDone(retCode:Int, resp:[UserData], token:String) {
        if (retCode != 0) {
            print("error")
            return
        }
        self.token = token;
        var i = 0
        user = resp[0]
        while (i < resp.count) {
            print(user._userName)
            i++;
        }
        requestManager.getMyGames((user._id?.integerValue)!)
    }
    func getGamesDone(retCode: Int, resp: [GameData]) {
        if (retCode != 0) {
            print("error")
            return
        }
        myGames = resp;    }
    
    func getWaitingGamesDone(retCode: Int, resp: [GameData]) {
        if (retCode != 0) {
            print("error")
            return
        }
        if (resp.count > 0) {
        currentGame = resp[0];
            //set myself to that game
            //requestManager.postPlayer(user)
        }
        else {
            requestManager.postNewGame(user)
        }
        
        
    }
    
    func postMyGamesDone(retCode: Int, resp:[GameData]) {
        currentGame = resp[0];
    }
    
    func setPlayerDone(retCode:Int, resp:[PlayerData])
    {
        //requestManager.addPlayer2Data(resp[0])
    }
    
    func setPlayerCodeDone(retCode:Int, resp:[PlayerData])
    {
        print("player code set");
    }
    
    func postPlayerDone(retCode:Int, resp:[PlayerData], gameID:NSNumber?) {

        print("postnewplayer");
        requestManager.updateGamePlayer2((gameID?.longLongValue)!, player:resp[0]);
    }
}