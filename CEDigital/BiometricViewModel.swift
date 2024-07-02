//
//  BiometricViewModel.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public class BiometricViewModel : BaseViewModel {
    
    
    let fingerPrintValidated: Box<FingerPrintValidateResponse?> = Box(nil)
    let tokenSession: Box<FacialRecognition?> = Box(nil)
    
    let facialValidatedIdentity: Box<FacialValidationMigrationResponse?> = Box(nil)
    
    
    
    
    
    // MARK: - Fingerprint
    
    func doValidationFingerPrintIdentity(post : FingerPrintValidatePost) {
        
        
        if(!Environment.enviroment.isEmpty){
            sendLogToFirebase(json: post.convertToString, document: AppPreferences.shared.getUser().sNumeroCarnet, action: "fingerprint")
        }
        
        self.isViewLoading.value = true
        
        BiometricClient.validationFingerPrintIdentity(post: post) { result in
            
            
            self.isViewLoading.value = false
            
            switch result {
            case .success(let result):
                
                if let response = result.data , response.bVerificacion {
                 
                    self.fingerPrintValidated.value = response
                }else {
                    
                    self.onMessageError.value = NetworkMessage(body: result.mensaje)
                }
                
            
            case .failure(let error):
                
                print(error)
                self.isViewLoading.value = false
                self.onMessageError.value = error
                
            }
        }
        
    }
    
    // MARK: - Facial Validation
    
    func doSetupFacialLoading(message : String) {
        self.viewWithStringLoading.value = message
    }
    
    func doGetTokenFacialRecognition(post: FacialTokenPost) {
        self.viewWithStringLoading.value = "gp_loading".localized
        
        BiometricClient.getSessionFacialToken(post: post) { result in
            
            self.viewWithStringLoading.value = ""
            
            switch result {
            case .success(let response):
                
                self.tokenSession.value = response.data
                
            case .failure(let error):
                
                print(error)
                self.onMessageError.value = error
                
            }
        }
        
    }
    
    
    func doFacialValidationIdentity(post: FacialValidationMigrationPost) {
        
        if(!Environment.enviroment.isEmpty){
            sendLogToFirebase(json: post.convertToString, document: AppPreferences.shared.getUser().sNumeroCarnet, action: "facial")
        }
        
        
        self.viewWithStringLoading.value = "facial_validating".localized
        
        BiometricClient.validationFacialIdentity(post: post) { result in
            
            self.viewWithStringLoading.value = ""
            
            switch result {
            case .success(let result):
                
                if let response = result.data {
                    self.facialValidatedIdentity.value = response
                }else {
                    
                    self.onMessageError.value = NetworkMessage(body: result.mensaje)
                }
                
            case .failure(let error):
                
                print(error)
                self.onMessageError.value = error
            }
        }
        
    }
    
    
    private func sendLogToFirebase(json : String, document: String = "", action: String = "") {
        
        BiometricClient.sendLogToFirebase(json: json, document: document, action: action)
    }
    
}

