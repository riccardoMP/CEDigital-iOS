//
//  MigracionesAPIRouter.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Alamofire

enum Networking {
    case validateDevice(post: ValidateDevicePost)
    case deviceInformation(post: DeviceRegisterPost)
    case validateUser(post: UserValidationPost)
}

extension Networking : TargetType {
    
    
    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .none
    }
    
    var path: RequestType {
        switch self {
        case .validateDevice:
            return .requestPath(path: "dispositivo/validar")
        case .deviceInformation:
            return .requestPath(path: "dispositivo/captura")
        case .validateUser:
            return .requestPath(path: "usuario/obtenerDatos")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .validateDevice:
            return .post
        case .deviceInformation:
            return .post
        case .validateUser:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .validateDevice(let post):
            let param =  ["sCodigoDispositivo": post.sCodigoDispositivo]
            
            return .requestParameters(parameters: param, encoding: .default)
            
        case .deviceInformation(let post):
            let param =  ["sCodigo": post.code,
                          "sNumero": post.documentNumber,
                          "sTipo": post.documentType
            ]
            
            return .requestParameters(parameters: param, encoding: .default)
            
        case .validateUser(let post):
            let param =  ["numeroBusqueda": post.numeroBusqueda,
                          "sCodeDispositivo": post.sCodeDispositivo,
                          "tipoBusqueda": post.tipoBusqueda,
                          "tipoDocumento": post.tipoDocumento
            ]
            
            return .requestParameters(parameters: param, encoding: .default)
            
        }
    }
    
    var multipartFormData: [String : Any] {
        return ["":""]
    }
    
    var headers: [String : String]? {
        var headersRequest : [String : String] = [:]
        
        headersRequest[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
        if let token = AppPreferences.shared.bearerToken {
            let bearerToken = "Bearer \(token)"
            headersRequest[HTTPHeaderField.authentication.rawValue] = bearerToken
        }
        
        return headersRequest
    }
}

