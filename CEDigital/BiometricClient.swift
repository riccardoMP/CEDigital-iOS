//
//  BiometricClient.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Alamofire
import FirebaseFirestore

class BiometricClient : BaseAPIClient {
    

    
    
    private static func isGoodRequest(data: Data?) -> Bool{
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObjectResponse.self, from: jsonData) {
            if(error.codigo == "200"){
                return true
            }else{
                return false
            }
            
        }
        return true
    }
    
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:BiometricRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,NetworkMessage>)->Void) -> DataRequest {
        
        
        //return AF.request(route)
        return session.request(route)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
//            .responseJSON { (response) in
                
                do {
                    
                
                    guard let jsonData = response.data else {
                        throw NetworkMessage(httpCode:0)
                    }
                    
                    if(isGoodRequest(data: jsonData)){
                        
                        if let bearerToken = response.response?.allHeaderFields[HTTPHeaderField.authentication.rawValue] as? String{
                            
                            AppPreferences.shared.bearerToken = bearerToken
                        }
                        
                        let result = try JSONDecoder().decode(T.self, from: jsonData)
                        completion(.success(result))
                    }else{
                        completion(.failure(self.parseApiError(data: jsonData, httpCode: response.response!.statusCode)))
                    }
                    
                    
                    
                    //print(String(data: response.data!, encoding: String.Encoding.utf8)!)
                    print(response.result)
                    
                } catch {
                    print("ERROR-DECODER: \(error)")
                    
                    NetworkManager.isUnreachable { _ in
                        completion(.failure(NetworkMessage( body: "generic_description_no_internet".localized, httpCode: SP.HTTP_CODE.NOT_INTERNET)))
                        
                    }
                    
                    NetworkManager.isReachable { _ in
                        
                        if let error = error as? NetworkMessage {
                            return completion(.failure(error))
                        }
                        completion(.failure(self.parseApiError(data: response.data, httpCode: response.response!.statusCode)))
                    }
                    
                    
                }
            }
        
        
    }
    
    
    
    private static func parseApiError(data: Data?, httpCode:Int) -> NetworkMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObjectResponse.self, from: jsonData) {
            print(error)
            return NetworkMessage( body: error.mensaje, httpCode: Int(error.codigo) ?? SP.HTTP_CODE.BAD_REQUEST)
        }
        return NetworkMessage(  httpCode: httpCode)
    }
    
    
    
    // MARK: - Fingerprint
    
    static func validationFingerPrintIdentity( post: FingerPrintValidatePost, completion:@escaping (Result<BaseResponse<FingerPrintValidateResponse>, NetworkMessage>)->Void) {
        
        performRequest(route: BiometricRouter.validationFingerPrintIdentity(post: post), completion: completion)
        
    }
    
    // MARK: - Facial Validation
    
    static func getSessionFacialToken( post: FacialTokenPost, completion:@escaping (Result<BaseResponseVeridium<FacialRecognition>, NetworkMessage>)->Void) {
        
        performRequest(route: BiometricRouter.getSessionFacialToken(post: post), completion: completion)
        
    }
    
    static func validationFacialIdentity( post: FacialValidationMigrationPost, completion:@escaping (Result<BaseResponse<FacialValidationMigrationResponse>, NetworkMessage>)->Void) {
        
        performRequest(route: BiometricRouter.validationFacialIdentity(post: post), completion: completion)
        
    }
    
    
    
    
}

