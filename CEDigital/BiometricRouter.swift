//
//  BiometricRouter.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Alamofire
import Foundation

enum BiometricRouter: URLRequestConvertible {
    
    
    case validationFingerPrintIdentity(post: FingerPrintValidatePost)
    
    //Facial
    case getSessionFacialToken(post: FacialTokenPost)
    
    case validationFacialIdentity(post: FacialValidationMigrationPost)
    
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
            
        case .validationFingerPrintIdentity:
            return .post
        case .getSessionFacialToken:
            return .post
            
        case .validationFacialIdentity:
            return .post
            
        }
        
    }
    
    // MARK: - Path
    
    
    private var path: URL {
        
        
        switch self {
            
            
        case .validationFingerPrintIdentity( _):
            
            let path = "\(Environment.rootURL)identidad/huella"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .getSessionFacialToken( _):
            
            let path = "\(Environment.rootURL)liveness/session-token-facial"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .validationFacialIdentity( _):
            
            let path = "\(Environment.rootURL)identidad/facial-validation"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        
        switch self {
            
            
        case .validationFingerPrintIdentity(let post):
            
            var paremeterFingerPrint = [AnyObject]()
            
            for fingerPrint in post.biometriaHuellas {
                
                let jsonFingerPrint: [String: Any]  = ["nIdDedo": fingerPrint.nIdDedo,
                                                       "xDedoConsultado": fingerPrint.xDedoConsultado,
                                                       "nScore": fingerPrint.nScore]
                
                paremeterFingerPrint.append(jsonFingerPrint as AnyObject)
            }
            
            return ["biometriaHuellas": paremeterFingerPrint,
                    "fotoHuellas": post.fotoHuellas,
                    "persona": [
                        "dFechaNacimiento": post.persona.dFechaNacimiento,
                        "sCorreoElectronico": post.persona.sCorreoElectronico,
                        "sIdDocumento": post.persona.sIdDocumento,
                        "sIdEstadoCivil": post.persona.sIdDocumento,
                        "sIdPaisNacimiento": post.persona.sIdPaisNacimiento,
                        "sIdPaisNacionalidad": post.persona.sIdPaisNacionalidad,
                        "sIdPaisResidencia": post.persona.sIdPaisResidencia,
                        "sIdPersona": post.persona.sIdPersona,
                        "sIdProfesion": post.persona.sIdProfesion,
                        "sMaterno": post.persona.sMaterno,
                        "sNombres": post.persona.sNombres,
                        "sNumeroDocumento": post.persona.sNumeroDocumento,
                        "sPaterno": post.persona.sPaterno,
                        "sSexo": post.persona.sSexo,
                    ]
            ]
            
            
            
            
        case .getSessionFacialToken(let post):
            return ["isKey": post.isKey,
                    "isNumeroDoc": post.isNumeroDoc
            ]
            
        case .validationFacialIdentity(let post):
            return [
                "isAuditTrailImage": post.isAuditTrailImage,
                "isFaceScan": post.isFaceScan,
                "isLowQualityAuditTrailImage": post.isLowQualityAuditTrailImage,
                "isToken": post.isToken,
                "isXUserAgent": post.isXUserAgent,
                "persona": [
                    "dFechaNacimiento": post.persona.dFechaNacimiento,
                    "sCorreoElectronico": post.persona.sCorreoElectronico,
                    "sIdDocumento": post.persona.sIdDocumento,
                    "sIdEstadoCivil": post.persona.sIdDocumento,
                    "sIdPaisNacimiento": post.persona.sIdPaisNacimiento,
                    "sIdPaisNacionalidad": post.persona.sIdPaisNacionalidad,
                    "sIdPaisResidencia": post.persona.sIdPaisResidencia,
                    "sIdPersona": post.persona.sIdPersona,
                    "sIdProfesion": post.persona.sIdProfesion,
                    "sMaterno": post.persona.sMaterno,
                    "sNombres": post.persona.sNombres,
                    "sNumeroDocumento": post.persona.sNumeroDocumento,
                    "sPaterno": post.persona.sPaterno,
                    "sSexo": post.persona.sSexo,
                ]
            ]
            
        }
        
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: path)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let token = AppPreferences.shared.bearerToken {
            let bearerToken = "Bearer \(token)"
            urlRequest.setValue(bearerToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
                print(dataString)
                
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                
                
            } catch {
                
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        
        print(urlRequest.description)
        
        
        return urlRequest
    }
}



