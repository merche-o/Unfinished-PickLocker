//
//  WSConnector.swift
//  BarclapWSFramework
//
//  Created by PC-1-Barclap on 14/09/2015.
//  Copyright (c) 2015 Sunclient. All rights reserved.
//

import Foundation
import Alamofire


class WSConnector {

    var caller:PickLockerWSProtocol
    var apiAdress:String = "https://morning-cove-9257.herokuapp.com/v1/"
    var params = Dictionary<String, AnyObject>()
    var header = [String: String]()
    var token:String = ""
    var httpMeth = Method.GET

    func downloadFile(url:NSURL)
    {
        var destination =  NSURL()
        Alamofire.download(httpMeth.value, url) { temporaryURL, response in
            let fileManager = NSFileManager.defaultManager()
            if let directoryURL:NSURL = fileManager.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]  {
                let pathComponent = response.suggestedFilename
                debugPrint(response)
                
                if let dest:NSURL =  directoryURL.URLByAppendingPathComponent(pathComponent!) {
                    if self.verifyFile(dest) {
                       // self.sendFileBack(dest)
                        destination = dest
                        return dest
                    }
                    else{
                        //TODO
                    }
                }
                else {
                    //TODO
                }
            }
            
            return temporaryURL
            }
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                
                // This closure is NOT called on the main queue for performance
                // reasons. To update your ui, dispatch to the main queue.
                dispatch_async(dispatch_get_main_queue()) {
                }
            }
            .response { _, _, _, error in
                if let error = error {
                    self.handleError(-1)
                    //self.caller.getResourceDone(-1, resp: nil)
                    print("Failed with error: \(error)")
                } else {
                   self.sendFileBack(destination)
                    print("Downloaded file successfully")
                }
        }    }
    
  
    
    func sendFileBack(tmpFile:NSURL) {
    }
    
    func verifyFile(filePath:NSURL) ->Bool
    {
            //TODO verifier fichier telecharger

            return true
    }
    
    init(caller:PickLockerWSProtocol) {
        self.caller = caller
    }
    
    func sendRequest(caller:PickLockerWSProtocol, req:Method, isTokenRequired:Bool=true) {
        //
        if (isTokenRequired) {
            if (self.token.isEmpty ) {
                self.token = caller.getToken()
            }
            if (self.token.isEmpty) {
                //print("No token provided")
                //passer le bon code erreur
                self.handleError(-1);
                
            }
        }
        var defaultEncoding = ParameterEncoding.JSON
        
        self.createHeader()
        if (req.value == .GET) {
            defaultEncoding = ParameterEncoding.URL
        }
        else {
            self.formatRequest(req)
        }
        Alamofire.request(req.value, apiAdress, parameters: params, headers: header, encoding: defaultEncoding)
            .responseJSON { _, resp, result in
                print("Response is : \(resp)")
                print("Result is : \(result)")
                print("DATA : \n \(result.value)")
                
                switch result {
                case .Success(_):
                    if (result.value as? NSArray != nil) {
                        self.parseResponse(0, response: result.value!)
                    }
                    else {
                        var tmp = Array<AnyObject>()
                        tmp.append(result.value!)
                        self.parseResponse(0, response: tmp)
                    }
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                    self.handleError(-1)
                    //TODO : Error management here
                    
                }
                
                
        }
    }
    
    func parseResponse(retCode:Int, response:AnyObject){
    /// Gestion des erreurs
    // --> appel la callback d'erreur si une une erreur surviens
    
    }
    
    func formatRequest(req:Method) {
        
    }

    
    func handleError(retCode:Int) {
        print("error")

    }

    
    func createHeader () {
        let tmp : Dictionary<String, String> = [
            "Authorization" :
                "Bearer " + self.token
        ]
        print(tmp["Authorization"])
        self.header = tmp
    }
    
   /* func parsePostResponse(retCode:Int64, response:AnyObject) {
    }*/
    
    func copyFile(src:NSURL, dest:NSURL) ->Bool {
        let filemanager = NSFileManager.defaultManager()
        do {
            try filemanager.copyItemAtPath(src.path!, toPath: dest.path!)
            try filemanager.removeItemAtPath(src.path!)
            return true
        } catch let e as NSError{
            print(e)
            return false
        }
    }
}