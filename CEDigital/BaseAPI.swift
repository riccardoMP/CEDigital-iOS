//
//  BaseAPI.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Alamofire
import Combine

class BaseAPI<T: TargetType> {
    
    typealias AnyPublisherResult<M> = AnyPublisher<M?, APIError>
    typealias FutureResult<M> = Future<M?, APIError>
    
    private let networking : AFNetworking
    
    /// ```
    /// Generic Base Class + Combine Concept + Future Promise
    ///
    /// ```
    ///
    /// - Returns: `etc promise(.failure(.timeout)) || promise(.success(value))`.
    ///
    
    init(networking : AFNetworking = AFNetworking(allHostsMustBeEvaluated: true)) {
        self.networking = networking
    }
    
    
    /// Make `Fetch API` call over the network.
    /// - Parameters:
    ///   - target: A `Generic class` where it has the body to send.
    ///   - responseClass: A `Generic Type` where it describes the target class
    ///   - timeoutInterval: The `timeout interval` variable, where it has a 20 seconds as a default value.
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, timeoutInterval: TimeInterval = 20) -> AnyPublisherResult<M> {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParameters(task: target.task)
        let targetPath = buildTarget(target: target.path)
        let url = (target.baseURL.desc + target.version.desc + targetPath)
        
        return FutureResult<M> { [weak self] promise in
            
            self?.networking.session.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers, requestModifier: { $0.timeoutInterval = timeoutInterval })
                .validate(statusCode: 200..<300)
                .responseDecodable(of: M.self) { response in
                    

                    
                    switch response.result {
                        
                    case .success(let value):
                        
                        if(self!.isGoodRequest(data: response.data)){
                            if let bearerToken = response.response?.allHeaderFields[HTTPHeaderField.authentication.rawValue] as? String{
                                AppPreferences.shared.bearerToken = bearerToken
                            }
                            
                            promise(.success(value))
                        }else{
                            let errorParsed : APIError = self!.parseApiError(data: response.data)
                            return promise(.failure(errorParsed))
                        }
                        
                        
                    case .failure(let error):
            
                        guard !error.isTimeout else {return promise(.failure(.timeout)) }
                        guard !error.isConnectedToTheInternet else { return promise(.failure(.noNetwork)) }
                        return promise(.failure(.general))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    /// Make `Fetch API` call over the network.
    /// - Parameters:
    ///   - target: A `Generic class` where it has the body to send.
    ///   - responseClass: A `Generic Type` where it describes the target class
    ///   - timeoutInterval: The `timeout interval` variable, where it has a 20 seconds as a default value.
    func fetchDataAsync<M: Decodable>(target: T, responseClass: M.Type, timeoutInterval: TimeInterval = 20) async throws -> M {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParameters(task: target.task)
        let targetPath = buildTarget(target: target.path)
        let url = (target.baseURL.desc + target.version.desc + targetPath)
        

        return try await withCheckedThrowingContinuation { continuation in
            
            self.networking.session.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers, requestModifier: { $0.timeoutInterval = timeoutInterval })
                .validate(statusCode: 200..<300)
                .responseDecodable(of: M.self) { response in
                    
                    switch response.result {
                        
                    case .success(let value):
                    
    
                        
                        if(self.isGoodRequest(data: response.data)){
                            if let bearerToken = response.response?.allHeaderFields[HTTPHeaderField.authentication.rawValue] as? String{
                                AppPreferences.shared.bearerToken = bearerToken
                            }
                            
                            continuation.resume( returning: value)
                        }else{
                            let errorParsed : APIError = self.parseApiError(data: response.data)
                            return continuation.resume(throwing: errorParsed)
                        }
                        
                        
                        
                        
                    case .failure(let error):
                            
                        guard !error.isTimeout else { return continuation.resume(throwing: APIError.timeout) }
                        guard !error.isConnectedToTheInternet else { return continuation.resume(throwing: APIError.noNetwork) }
                        
                        return continuation.resume(throwing: error)
                    }
                }
        }
        
    }
    
    /// Make `Fetch multiplatform API` call over the network.
    /// - Parameters:
    ///   - target: A `Generic class` where it has the body to send.
    ///   - responseClass: A `Generic Type` where it describes the target class
    ///   - timeoutInterval: The `timeout interval` variable, where it has a 20 seconds as a default value.
    func fetchMultimediaData<M: Decodable>(target: T, responseClass: M.Type, timeoutInterval: TimeInterval = 20) -> AnyPublisherResult<M> {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let targetPath = buildTarget(target: target.path)
        let url = (target.baseURL.desc + target.version.desc + targetPath)
        let multipartList = target.multipartFormData
        
        return FutureResult<M> { [weak self] promise in
            
            self?.networking.session.upload(
                multipartFormData: { multipartFormData in
                    
                    for (key,keyValue) in multipartList{
                        switch keyValue {
                            
                        case  is String:
                            let stringValue : String? = (keyValue as? String)
                            if let data =  stringValue?.data(using: .utf8){
                                multipartFormData.append(data , withName: key)
                            }
                            
                        default: break
                        }
                    }
                    
                },
                to: url, method: method, headers: headers, requestModifier: { $0.timeoutInterval = timeoutInterval })
            .validate(statusCode: 200..<300)
            .responseDecodable(of: M.self) { response in
                switch response.result {
                    
                case .success(let value):
                    promise(.success(value))
                    
                case .failure(let error):
                    guard !error.isTimeout else {return promise(.failure(.timeout)) }
                    guard !error.isConnectedToTheInternet else { return promise(.failure(.noNetwork)) }
                    return promise(.failure(.general))
                }
                
            }
            
            
        }
        .eraseToAnyPublisher()
    }
    
    
    
    private func isGoodRequest(data: Data?) -> Bool {
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
    private func parseApiError(data: Data?) -> APIError {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObjectResponse.self, from: jsonData) {
            print(error)
            
            return APIError.statusMessage(message: error.mensaje)
        }
        return APIError.general
    }
    
    // MARK: - Network Availability
    func checkInternetAvailability() -> AnyPublisher<Bool, APIError> {
        let isNetworkAvailable = NetworkReachabilityManager()?.isReachable ?? false
        if(isNetworkAvailable){
            return  Just(true)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }else{
            let networkFail = Fail<Bool, APIError>(error: APIError.noNetwork)
            return networkFail.eraseToAnyPublisher()
        }
    }
}
