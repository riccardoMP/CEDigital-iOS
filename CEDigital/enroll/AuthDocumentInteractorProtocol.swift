//
//  AuthDocumentInteractorProtocol.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Combine

protocol AuthDocumentInteractorProtocol : AnyObject {
    func isDataValid(documentNumber: String) -> AnyPublisher <Void, APIError>
    
    func postDeviceInformation(documentNumber: String) -> AnyPublisher <BaseDTO<EnrollResponse>?, APIError>
    func processDeviceInformation(documentNumber: String, bearerToken: String?) -> AnyPublisher<UserValidationPost, APIError>
    
    func postValidateUser(post: UserValidationPost) -> AnyPublisher <BaseDTO<UserCE>?, APIError>
    func processUserValidated(user: UserCE?) -> AnyPublisher<UserRegisterPost, APIError>
    
}

