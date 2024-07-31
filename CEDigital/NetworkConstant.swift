//
//  NetworkConstant.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

struct SP {
    struct ProductionServer {
     
        static let baseURL = Environment.rootURL
   
    }
    
    struct HTTP_CODE {
        static var BAD_REQUEST = 400
        static var NOT_FOUND = 404
        static var INT_SRV_ERROR = 500
        static var UNAUTHORIZED = 401
        static var NOT_INTERNET = 1024
    }
    

    
    struct Document {
        static let DNI = "DNI"
    }
    
    struct APIParameterKey {
        static let documentType = "documentType"
        static let documentNumber = "documentNumber"
    }
    


}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case documentNumber = "documentNumber"
    case isKey = "is-key"
    case token = "token"
    
    
    
    
}

enum ContentType: String {
    case json = "application/json"
}
