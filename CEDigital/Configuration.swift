//
//  Configuration.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

enum BaseURLType {
    
    case baseApi
    
    case custom(url : String)
    
    var desc : String {
        switch self {
        case .baseApi :
            return Environment.rootURL
        case .custom(url: let url):
            return url
        
        }
    }
}

enum VersionType {
    case none
    case v1, v2
    
    var desc : String {
        switch self {
        case .none :
            return ""
        case .v1 :
            return "/v1"
        case .v2 :
            return "/v2"
        }
    }
}
