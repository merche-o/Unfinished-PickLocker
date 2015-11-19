//
//  GameConnector.swift
//  PickLocker
//
//  Created by Ainur on 24/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import Foundation

import Foundation


class GameConnector: WSConnector {
    var mode:Int = 0;
    var data = UserData()

    override init(caller: PickLockerWSProtocol) {
        super.init(caller: caller)
    }
    
    override func formatRequest(req:Method) {
        if (req == Method.POST) {
            var parameters = [
                "userid1": data._id!,
                "_player1":  [String : NSObject]()
            ]
            
            let tmp = [
                    "userid": data._id!,
                ]
                
            
            parameters["_player1"] = tmp
            print(parameters)
            self.params = parameters
        }
        
    }

    
    override func parseResponse(retCode: Int, response: AnyObject) {
        //doit parser response
        super.parseResponse(retCode, response: response)
        let responseParsed = [GameData] ()
        
        // parsing
        var i:Int
        i = 0
        
        //tmp._idPhoto =
        while (i < response.count)
        {
              let tmp = GameData()
            tmp._id = response[i].valueForKeyPath("id") as? NSNumber
            tmp._statusGame = response[i].valueForKeyPath("status_game") as? String
             tmp._statusRoom = response[i].valueForKeyPath("status_room") as? String
             tmp._nbTurn = response[i].valueForKeyPath("nb_turn") as? NSNumber
            tmp._userId1 = response[i].valueForKeyPath("userid1") as? NSNumber
            tmp._userId2 = response[i].valueForKeyPath("userid2") as? NSNumber
            tmp._player1 = parsePlayer(response[i].valueForKeyPath("_player1")!)
            tmp._player2 = parsePlayer(response[i].valueForKeyPath("_player2")!)
            i++;
        }
        if (mode == 0){
        caller.getGamesDone(retCode, resp: responseParsed)
        }
        else if (mode == 1){
        caller.getMyGamesDone(retCode, resp: responseParsed)
        }
        else if (mode == 2)
        {
            caller.postMyGamesDone(retCode, resp: responseParsed)
        }
    }
    
    func parsePlayer(response:AnyObject)->PlayerData {
        let tmp = PlayerData()
        tmp._id = response.valueForKeyPath("id") as? NSNumber
        tmp._userId = response.valueForKeyPath("userid") as? NSNumber
        tmp._code = response.valueForKeyPath("code") as? String
        tmp._type = response.valueForKeyPath("type") as? String
        tmp._try = response.valueForKeyPath("try") as? NSNumber
        tmp._gameId = response.valueForKeyPath("gameId") as? NSNumber
        return tmp;
    }
    
    func parseBonus(response:AnyObject)->[BonusData] {
        var resp = [BonusData]()
        var i = 0
        
        while i < response.count {
            let tmp = BonusData()
            tmp._id = response[i].valueForKeyPath("id") as? NSNumber
            tmp._owner = response[i].valueForKeyPath("owner") as? NSNumber
            tmp._name = response[i].valueForKeyPath("name") as? String
            tmp._type = response[i].valueForKeyPath("type") as? String
            resp.append(tmp)
            i++
        }
        return resp;
    }
    
    
    func getMyGames(userid:Int) {
        mode = 0;
        self.apiAdress += "mygames/" + String(userid)
        self.httpMeth = Method.GET
        sendRequest(caller, req: self.httpMeth)
    }
    
    func getWaitingGames(userid:Int) {
        mode = 1;
        self.apiAdress += "gameswaiting/" + String(userid)
        self.httpMeth = Method.GET
        sendRequest(caller, req: self.httpMeth)
    }
    
    func postNewGame(user:UserData) {
        mode = 2;
        self.data = user;
        self.apiAdress += "games?populate=_player1"
        self.httpMeth = Method.POST
        sendRequest(caller, req: self.httpMeth)
    }
    
    
    override func  handleError(retCode:Int) {
        super.handleError(retCode)
        self.caller.getGamesDone(retCode, resp: [GameData]())
    }
    
    
}
