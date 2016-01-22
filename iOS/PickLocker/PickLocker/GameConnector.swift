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
    var player2 = PlayerData()

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
        else if (req == Method.PUT) {
            let parameters = [
            "status_room": "in_game",
            "status_game" : "p2",
            "userid2":player2._userId!,
            "_player2":player2._id!
            ]
            self.params = parameters
        }
        
    }

    
    override func parseResponse(retCode: Int, response: AnyObject) {
        //doit parser response
        super.parseResponse(retCode, response: response)
        var responseParsed = [GameData] ()
        
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
            if let _ = response[i].valueForKeyPath("_player1") as? NSNumber {
             //have to get player into _player1
            }
            else {
            tmp._player1 = parsePlayer(response[i].valueForKeyPath("_player1")!)
            }
             if let _ = response[i].valueForKeyPath("_player1") as? NSNumber {
             //have to get player into _player1
             }
             else {
                if let _  = response[i].valueForKeyPath("_player2") {
            tmp._player2 = parsePlayer(response[i].valueForKeyPath("_player2")!)
            }
            }
            responseParsed.append(tmp);
            i++;
        }
        if (mode == 0){
        caller.getGamesDone(retCode, resp: responseParsed)
        }
        else if (mode == 1){
        caller.getWaitingGamesDone(retCode, resp: responseParsed)
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
        self.apiAdress += "games"
        self.httpMeth = Method.POST
        sendRequest(caller, req: self.httpMeth)
    }
    
    func updateGamePlayer2(gameId:Int64, player2:PlayerData)
    {
        mode = -1;
        self.apiAdress += "games/" + String(gameId)
        self.httpMeth = Method.PUT
        self.player2 = player2;
        sendRequest(caller, req: self.httpMeth)
    }
    
    
    override func  handleError(retCode:Int) {
        super.handleError(retCode)
        self.caller.getGamesDone(retCode, resp: [GameData]())
    }
    
    
}
