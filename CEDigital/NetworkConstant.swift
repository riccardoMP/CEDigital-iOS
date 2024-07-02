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
        //Production
         /*static let baseURL = "https://tcqallarix.azurewebsites.net/"
         static let baseURLVacation = "https://vcqallarix.azurewebsites.net/"
         static let baseURLFlexPlace = "https://fxqallarix.azurewebsites.net/"
         static let baseURLNotification = "https://npqallarix.azurewebsites.net/"
         static let baseURLAmbassador = "https://ceqallarix.azurewebsites.net/"
         static let baseURLChatBot = "https://qnaqallarix.azurewebsites.net/"
         static let baseURLSamiv2 = "https://apimngr-genesis-prod.azure-api.net/hrmanagement/chatbot/"
         static let baseURLAllToField = "https://tacqallarix.azurewebsites.net/"
         static let baseURLPersonalEntry = "https://roqallarix.azurewebsites.net/"
         static let baseURLBearer = "https://wa-qallarix-prod.azurewebsites.net/azauth/acccess"
         
         static let suscriptionKey = "95383afd111146cf9ba1225c574fd03f"
        
    
         static let topicFCM = "productioniOS"
         static let topicNewFCM = "QXNotification"*/
        
         
         
        
        //QA
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
