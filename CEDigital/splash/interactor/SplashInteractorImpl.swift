//
//  SplashInteractorImpl.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Combine


class SplashInteractorImpl : BaseAPI<Networking>, SplashInteractorProtocol {
    
    let appPreferences : AppPreferences = AppPreferences()
    
    
    func isNetworkAvailable() -> AnyPublisher<Bool, APIError> {
        return checkInternetAvailability()
    }
    
    func validateDevice() -> AnyPublisher<BaseDTO<Bool>?, APIError> {
        let post = ValidateDevicePost(sCodigoDispositivo: appPreferences.parametryCEObject.uuid, uIdPersona: appPreferences.parametryCEObject.uidPersona)
        return self.fetchData(target: .validateDevice(post: post), responseClass: BaseDTO<Bool>.self)
    }
    
    
    func processDeviceValidationResponse(isValid: Bool?) -> AnyPublisher<Bool, APIError> {
        guard let isValid = isValid else { return Fail<Bool, APIError>(error: APIError.general).eraseToAnyPublisher() }
        
        let isDeviceValid : Bool = appPreferences.parametryCEObject.isUserEnrolled && isValid
        
        return Just(isDeviceValid)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func generateUUID(){
        if(appPreferences.parametryCEObject.uuid.isEmpty){
            ParametryCEFluentBuilder(builder: appPreferences.parametryCEObject)
                .setUUID(uuid: UUID().uuidString.replacingOccurrences(of: "-", with: ""))
                .build()
        }
    }
}

