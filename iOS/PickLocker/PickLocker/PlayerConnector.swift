//
//  PlayerConnector.swift
//  PickLocker
//
//  Created by Ainur on 27/11/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import Foundation

//
//  SingInConnector.swift
//  PickLocker
//
//  Created by Ainur on 22/10/2015.
//  Copyright © 2015 A&D. All rights reserved.
//

import Foundation


class PlayerConnector: WSConnector {
    
    var data = ""
    var gameID:NSNumber?;
    var userID:NSNumber?;
    var mode = 0;
    override init(caller: PickLockerWSProtocol) {
        super.init(caller: caller)
    }
    
    override func formatRequest(req:Method) {
        if (req == Method.PUT){
        let response : Dictionary<String, AnyObject> = [
            "code" : self.data,
        ]
            self.params = response
        }
        else if (req == Method.POST) {
            let response : Dictionary<String, AnyObject> = [
                "code" : self.data,
                "userid": self.userID!,
                "gameid": self.gameID!
            ]
            self.params = response

        }
    }
    
    override func parseResponse(retCode: Int, response: AnyObject) {
        //doit parser response
        super.parseResponse(retCode, response: response)
        var responseParsed = [PlayerData] ()
        
        // parsing
        var i:Int
        i = 0
        
        //tmp._idPhoto =
        while (i < response.count)
        {
            let tmp = PlayerData()
            tmp._id = response[i].valueForKeyPath("id") as? NSNumber
            tmp._userId = response[i].valueForKeyPath("userid") as? NSNumber
            tmp._code = response[i].valueForKeyPath("code") as? String
            tmp._type = response[i].valueForKeyPath("type") as? String
            tmp._try = response[i].valueForKeyPath("try") as? NSNumber
            tmp._gameId = response[i].valueForKeyPath("gameId") as? NSNumber
            responseParsed.append(tmp)

            i++;
        }
        if (mode == 0) {
        caller.postPlayerDone(retCode, resp:responseParsed, gameID: gameID)
        }
        else if (mode == 1)
        {
            caller.setPlayerCodeDone(retCode, resp: responseParsed);
        }
    }
    
    
    func setPlayerCode(code:String, playerId:Int64) {
        
        mode = 1;
        self.data = code
        self.apiAdress += "players/" + String(playerId)
        self.httpMeth = Method.PUT
        sendRequest(caller, req: self.httpMeth)
    }
    
    func postPlayerInGame(code:String, userId:Int64, gameID:Int64)
    {
        mode = 0;
        self.data = code
        self.userID = NSNumber(longLong: userId)
        self.gameID = NSNumber(longLong: gameID)
        self.apiAdress += "players/";
        self.httpMeth = Method.POST;
        sendRequest(caller, req: self.httpMeth)
        
    }
    
    override func  handleError(retCode:Int) {
        super.handleError(retCode)
        self.caller.postPlayerDone(retCode, resp: [PlayerData](), gameID: gameID)
    }
    
    
}
