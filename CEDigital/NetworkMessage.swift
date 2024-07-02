//
//  NetworkMessage.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

class NetworkMessage: Error {
    
    // MARK: - Vars & Lets
    
    var title = ""
    var body = ""
    var httpCode = SP.HTTP_CODE.BAD_REQUEST
    
    // MARK: - Intialization
    
    init(body:String = "", httpCode:Int) {
        self.title = "general_oops".localized
        self.httpCode = httpCode
        
        switch httpCode {
        case SP.HTTP_CODE.NOT_INTERNET:
            self.body = body
        case SP.HTTP_CODE.INT_SRV_ERROR, SP.HTTP_CODE.NOT_FOUND:
            self.body = "general_error_400".localized
        case 400..<500:
            self.body = (body.isEmpty) ? "general_error_400".localized : body
        default:
            self.body = "general_error_400".localized
        }
    }
    
    init(body:String) {
        self.title = "general_oops".localized
        self.body = body
        
    }
    
}
