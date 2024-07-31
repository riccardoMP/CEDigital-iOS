//
//  AuthDocumentInteractorImpl.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Combine


class AuthDocumentInteractorImpl : BaseAPI<Networking>, AuthDocumentInteractorProtocol{
    
    let appPreferences : AppPreferences = AppPreferences()
    
    
    func isDataValid(documentNumber: String) -> AnyPublisher<Void, APIError> {
        if(documentNumber.isEmpty){
            let fail = getFailMessage(message: "message_document_empty".localized, outputType: Void.self)
            return fail.eraseToAnyPublisher()
        }
        
        if(!documentNumber.isExpresionValid(expression: Constants.REGEX_DOCUMENT)){
            let fail = getFailMessage(message: "auth_error_document".localized, outputType: Void.self)
            return fail.eraseToAnyPublisher()
        }
        
        return Just(())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func postDeviceInformation(documentNumber: String) -> AnyPublisher<BaseDTO<EnrollResponse>?, APIError> {
        let post = DeviceRegisterPost(code: RSAKeyManager.shared.getMyPublicKeyString() ?? "", documentNumber: documentNumber, documentType: Constants.DOCUMENT_TYPE_CE)
        return self.fetchData(target: .deviceInformation(post: post), responseClass: BaseDTO<EnrollResponse>.self)
    }
    
    func processDeviceInformation(documentNumber: String, bearerToken: String?) -> AnyPublisher<UserValidationPost, APIError> {
        guard let bearerToken = bearerToken else { return Fail<UserValidationPost, APIError>(error: APIError.general).eraseToAnyPublisher() }
        
        appPreferences.bearerToken = bearerToken
        
        let post = UserValidationPost(numeroBusqueda: documentNumber, sCodeDispositivo: appPreferences.parametryCEObject.uuid, tipoBusqueda: EnumTypeEditText.DOCUMENT.rawValue, tipoDocumento: Constants.DOCUMENT_TYPE_CE)
        
        return Just(post)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    
    func postValidateUser(post: UserValidationPost) -> AnyPublisher<BaseDTO<UserCE>?, APIError> {
        return self.fetchData(target: .validateUser(post: post), responseClass: BaseDTO<UserCE>.self)
    }
    
    func processUserValidated(user: UserCE?) -> AnyPublisher<UserRegisterPost, APIError> {
        guard let user = user else {
            let fail = getFailMessage(message: "general_error_400".localized, outputType: UserRegisterPost.self)
            return fail.eraseToAnyPublisher()
        }
        
        ParametryCEFluentBuilder(builder: appPreferences.parametryCEObject)
            .setDocumentNumber(documentNumber: user.sNumeroCarnet)
            .setNumeroTramite(numeroTramite: user.sNumeroTramite)
            .setUIDPersona(uidPersona: user.uIdPersona)
            .setIdDocument(idDocumento: Constants.DOCUMENT_TYPE_CE)
            .build()
        
        appPreferences.prefUserStored = AppUtils.encodeObject(user)
        
        let post : UserRegisterPost = UserRegisterPostFluentBuilder(builder: UserRegisterPost()).setEmail(sCorreo: user.sEmail)
            .setPhone(sNumero: user.sTelefono)
            .setIdDocument(sIdDocumento: Constants.DOCUMENT_TYPE_CE)
            .setCarnetDoc(sNumeroDoc: user.sNumeroCarnet)
            .setUID(uidPersona: user.uIdPersona)
            .setDeviceCode(sCodeDispositivo: AppPreferences.shared.parametryCEObject.uuid)
            .build()
        
        return Just(post)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        
    }
    
    
    private func getFailMessage<T>(message: String, outputType: T.Type) -> Fail<T, APIError>{
        return Fail<T, APIError>(error: APIError.statusMessage(message: message))
    }
    
}
