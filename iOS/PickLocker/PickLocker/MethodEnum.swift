//
//  MethodEnum.swift
//  BarclapWSFramework
//
//  Created by PC-1-Barclap on 23/09/2015.
//  Copyright © 2015 Sunclient. All rights reserved.
//

import Foundation
import Alamofire

public enum Method: String {
    
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
    var value: Alamofire.Method {
        switch self {
        case OPTIONS:
            return .OPTIONS
        case GET:
            return .GET
        case HEAD:
            return .HEAD
        case POST:
            return .POST
        case PUT:
            return .POST
        case PATCH:
            return .PATCH
        case DELETE:
            return .DELETE
        case TRACE:
            return .TRACE
        case CONNECT:
            return .CONNECT
        }
    }
}
