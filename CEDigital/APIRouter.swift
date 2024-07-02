//
//  APIRouter.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Alamofire


enum APIRouter: URLRequestConvertible {
    
    //Splash
    case deviceInformation(post: DeviceInformationPost)
    case refreshToken
    
    case validateDevice(post: ValidateDevicePost)
    case validationUser(post: UserValidationPost)
    case updateUser(update: InformationUserUpdate)
    case generateCode(post: GenerateCodePost)
    case validationCode(post: ValidationCodePost)
    case registerUser(post: UserRegisterPost)
    case loginUser(post: LoginPost)
    case updatePassword(post: UpdatePasswordPost)
    case unlinkDevice(post: UnlinkDevicePost)
    
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        
        case .deviceInformation:
            return .post
        case .refreshToken:
            return .post
        case .validateDevice:
            return .post
        case .validationUser:
            return .post
        case .updateUser:
            return .put
        case .generateCode:
            return .post
        case .validationCode:
            return .post
        case .registerUser:
            return .post
        case .loginUser:
            return .post
        case .updatePassword:
            return .post
        case .unlinkDevice:
            return .post
        }
        
    }
    
    // MARK: - Path
    
    
    private var path: URL {
        
        
        switch self {
        
        
        case .deviceInformation( _):
            
            let path = "\(Environment.rootURL)dispositivo/captura"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .refreshToken:
            
            let path = "\(Environment.rootURL)token"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .validateDevice( _):
            
            let path = "\(Environment.rootURL)dispositivo/validar"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .validationUser( _):
            
            let path = "\(Environment.rootURL)usuario/obtenerDatos"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .updateUser( _):
            
            let path = "\(Environment.rootURL)usuario/updateUser"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .generateCode( _):
            
            let path = "\(Environment.rootURL)codigo/generar"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .validationCode( _):
            
            let path = "\(Environment.rootURL)codigo/validar"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .registerUser( _):
            
            let path = "\(Environment.rootURL)enrolar/usuario"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
            
        case .loginUser( _):
            
            let path = "\(Environment.rootURL)usuario/login"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        case .updatePassword( _):
            
            let path = "\(Environment.rootURL)usuario/actualizarClave"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
            
        case .unlinkDevice( _):
            
            let path = "\(Environment.rootURL)dispositivo/desvincular"
            let urlComponents = URLComponents(string: path)!
            
            print(urlComponents.url!)
            return urlComponents.url!
            
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        
        switch self {
        
        
        
        case .deviceInformation(let post):
            return ["sCodigo": post.sCodigo,
                    "sNumero": post.sNumero,
                    "sTipo": post.sTipo
            ]
            
        case .refreshToken:
            return nil
            
        case .validateDevice(let post):
            return ["sCodigoDispositivo": post.sCodigoDispositivo
            ]
        case .validationUser(let post):
            return ["numeroBusqueda": post.numeroBusqueda,
                    "sCodeDispositivo": post.sCodeDispositivo,
                    "tipoBusqueda": post.tipoBusqueda,
                    "tipoDocumento": post.tipoDocumento
            ]
            
        case .updateUser(let update):
            return ["sTelefono": update.sTelefono,
                    "sCorreo": update.sCorreo,
                    "uIdPersona": update.uIdPersona
            ]
            
            
            
        case .generateCode(let post):
            return ["sCodeDispositivo": post.sCodeDispositivo,
                    "sCodigo": post.sCodigo,
                    "sCorreo": post.sCorreo,
                    "sIntentos": post.sIntentos,
                    "sTipoCodigo": post.sTipoCodigo,
                    "uidPersona": post.uidPersona,
                    "sTelefono": post.sTelefono,
                    "sTipoNotificacion": post.sTipoNotificacion
            ]
            
        case .validationCode(let post):
            return ["sCodeDispositivo": post.sCodeDispositivo,
                    "sCodigo": post.sCodigo,
                    "sCorreo": post.sCorreo,
                    "sIntentos": post.sIntentos,
                    "sTipoCodigo": post.sTipoCodigo,
                    "uidPersona": post.uidPersona
            ]
            
        case .registerUser(let post):
            return ["sClave": post.sClave,
                    "sCodeDispositivo": post.sCodeDispositivo,
                    "sCodigo": post.sCodigo,
                    "sCorreo": post.sCorreo,
                    "sIdDocumento": post.sIdDocumento,
                    "sNumero": post.sNumero,
                    "sNumeroDoc": post.sNumeroDoc,
                    "sSO": post.sSO,
                    "uidPersona": post.uidPersona,
            ]
            
        case .loginUser(let post):
            return ["sClave": post.sClave,
                    "sCodeDispositivo": post.sCodeDispositivo,
                    "sNumeroDoc": post.sNumeroDoc,
                    "sNumeroTramite": post.sNumeroTramite,
                    "tipoDocumento": post.tipoDocumento,
                    "sSO": post.sSO,
                    
            ]
            
            
        case .updatePassword(let post):
            return ["sClave": post.sClave,
                    "sCodeDispositivo": post.sCodeDispositivo,
                    "sNumeroDoc": post.sNumeroDoc,
                    "sNumeroTramite": post.sNumeroTramite,
                    "tipoDocumento": post.tipoDocumento
            ]
            
        case .unlinkDevice(let post):
            return ["sCodigoDispositivo": post.sCodigoDispositivo,
                    "uIdPersona": post.uIdPersona
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


