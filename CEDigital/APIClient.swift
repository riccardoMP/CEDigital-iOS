//
//  APIClient.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Alamofire
import FirebaseFirestore

class APIClient : BaseAPIClient {
    
    
    
    
    private static func performRequestDownload( url:String, completion:@escaping (Result<NSURL,NetworkMessage>)->Void) {
        
        
        print(url)
        
        
        let urlEnconded = URL(string: url)!
        let namePDF = urlEnconded.lastPathComponent
        
        
        let destination = DownloadRequest.suggestedDownloadDestination(
            for: .documentDirectory,
            in: .userDomainMask,
            options: [.removePreviousFile, .createIntermediateDirectories]
        )
        
        
        AF.download(urlEnconded, to:destination)
            .downloadProgress { (progress) in
                
                print("Download Progress: \((String)(progress.fractionCompleted))")
                print("completedUnit: \(progress.completedUnitCount)")
                print("totalUnitCount: \(progress.totalUnitCount)")
                
            }
            .responseData { (data) in
                
                
                if let error = data.error {
                    
                    completion(.failure(NetworkMessage( body: "Se presentó un problema en la descarga del PDF, inténtenlo de nuevo.")))
                    
                    print("Failed with error: \(error)")
                    
                }else if (data.response?.statusCode == 404){
                    completion(.failure(NetworkMessage( body: "Se presentó un problema en la descarga del PDF, inténtenlo de nuevo.")))
                    
                }else {
                    
                    // then lets create your document folder url
                    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    // lets create your destination file url
                    let destinationUrl = documentsDirectoryURL.appendingPathComponent(namePDF)
                    
                    completion(.success(destinationUrl as NSURL))
                    
                    
                }
                
                
            }
        
        
        
    }
    
    private static func performRequestFirebase<T:Decodable>( pathFB:String, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,NetworkMessage>)->Void) {
        
        let db = Firestore.firestore()
        
        db.collection(pathFB).getDocuments() { (querySnapshot, err) in
            
            do {
                
                if let document = querySnapshot!.documents.first{
                    
                    guard let jsonDataFB = try? JSONSerialization.data(withJSONObject:document.data()) else {
                        throw NetworkMessage(httpCode:0)
                    }
                    
                    let fireBaseResponse = try JsonFireBaseResponse.decode(data: jsonDataFB)
                    
                    
                    let jsonValue = (fireBaseResponse.jsonValue != nil) ? fireBaseResponse.jsonValue : fireBaseResponse.valueJson
                    
                    let result = try T.decode(data: Data(jsonValue!.utf8))
                    
                    completion(.success(result))
                }else{
                    throw NetworkMessage(httpCode:0)
                }
                
                
                
                
            } catch {
                
                print("ERROR-DECODER: \(error)")
                
                if let error = error as? NetworkMessage {
                    return completion(.failure(error))
                }
                completion(.failure(self.parseApiError(data: nil, httpCode: SP.HTTP_CODE.BAD_REQUEST)))
            }
            
        }
        
    }
    
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
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,NetworkMessage>)->Void) -> DataRequest {
        
        
        //return AF.request(route)
        return session.request(route)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                
                do {
                    
                    guard let jsonData = response.data else {
                        throw NetworkMessage(httpCode:0)
                    }
                    
                    if(isGoodRequest(data: jsonData)){
                        
                        /*if let bearerToken = response.response?.allHeaderFields[HTTPHeaderField.authentication.rawValue] as? String{
                            
                            AppPreferences.shared.bearerToken = bearerToken
                        }*/
                        
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
    
    // MARK: - Splash
    static func validateDevice( post: ValidateDevicePost, completion:@escaping (Result<ValidateDeviceResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.validateDevice(post: post), completion: completion)
        
    }
    
    static func deviceInformation( post: DeviceInformationPost, completion:@escaping (Result<BaseResponse<EnrollResponse>, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.deviceInformation(post: post), completion: completion)
        
    }
    
    static func refreshToken(  completion:@escaping (Result<Bool, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.refreshToken, completion: completion)
        
    }
    
    // MARK: - Enroll
    static func validationUser( post: UserValidationPost, completion:@escaping (Result<BaseResponse<UserCE>, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.validationUser(post: post), completion: completion)
        
    }
    
    
    static func updateUser( update: InformationUserUpdate, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.updateUser(update: update), completion: completion)
        
    }
    
    static func firebaseValidationUser(pathFB: String, completion:@escaping (Result<UserValidationResponse, NetworkMessage>)->Void) {
        
        performRequestFirebase(pathFB: pathFB, completion: completion)
        
    }
    
    static func generateCode( post: GenerateCodePost, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.generateCode(post: post), completion: completion)
        
    }
    
    static func firebaseGenerateCode(pathFB: String, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequestFirebase(pathFB: pathFB, completion: completion)
        
    }
    
    static func validationCode( post: ValidationCodePost, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.validationCode(post: post), completion: completion)
        
    }
    
    static func registerUser( post: UserRegisterPost, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.registerUser(post: post), completion: completion)
        
    }
    
    static func downloadFile(url: String, completion:@escaping (Result<NSURL, NetworkMessage>)->Void) {
        
        performRequestDownload(url: url, completion: completion)
        
        
    }
    
    
    // MARK: - Login
    static func loginUser( post: LoginPost, completion:@escaping (Result<LoginResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.loginUser(post: post), completion: completion)
        
    }
    
    static func firebaseLogin(pathFB: String, completion:@escaping (Result<LoginResponse, NetworkMessage>)->Void) {
        
        performRequestFirebase(pathFB: pathFB, completion: completion)
        
    }
    
    static func updatePassword( post: UpdatePasswordPost, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.updatePassword(post: post), completion: completion)
        
    }
    
    static func unlinkDevice( post: UnlinkDevicePost, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequest(route: APIRouter.unlinkDevice(post: post), completion: completion)
        
    }
    
    static func fireBaseUnlinkDevice( pathFB: String, completion:@escaping (Result<GeneralResponse, NetworkMessage>)->Void) {
        
        performRequestFirebase(pathFB: pathFB, completion: completion)
        
    }
    
    
    
}
