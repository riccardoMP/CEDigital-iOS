//
//  SplashInteractorProtocol.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Combine

protocol SplashInteractorProtocol : AnyObject {
    func isNetworkAvailable() -> AnyPublisher <Bool, APIError>
    
    func validateDevice() -> AnyPublisher <BaseDTO<Bool>?, APIError>
    func generateUUID()
    func processDeviceValidationResponse(isValid : Bool?) -> AnyPublisher <Bool, APIError>
    
}
