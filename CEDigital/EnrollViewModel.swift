//
//  EnrollViewModel.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 10/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Firebase

public class EnrollViewModel : BaseViewModel {
    
    
    let deviceInformation: Box<String?> = Box(nil)
    let userCEObserver: Box<UserCE?> = Box(nil)
    let codeGenerated: Box<String?> = Box(nil)
    let userUpdated: Box<String?> = Box(nil)
    let codeValidated: Box<Bool?> = Box(nil)
    let codeValidatedFirebase: Box<Bool?> = Box(nil)
    
    let onValidateCodeError: Box<NetworkMessage?> = Box(nil)
    
    
    func doDeviceInformation(post : DeviceInformationPost) {
        
        self.isViewLoading.value = true
        
        APIClient.deviceInformation(post: post) { result in
            
            
            switch result {
            case .success(let response):
                
                self.deviceInformation.value = response.data?.authorization
                
            case .failure(let error):
                
                print(error)
                self.isViewLoading.value = false
                self.onMessageError.value = error
                
            }
        }
        
    }
    
    // MARK: - ValidationUser
    func doValidationUser(post : UserValidationPost) {
        
        self.isViewLoading.value = true
        
        APIClient.validationUser(post: post) { result in
            
            self.isViewLoading.value = false
            switch result {
            case .success(let response):
                
                self.userCEObserver.value = response.data
                
            case .failure(let error):
                
                print(error)
                
                self.onMessageError.value = error
                
            }
        }
        
    }
    
    func doFirebaseValidationUser() {
        
        self.isViewLoading.value = true
        
        APIClient.firebaseValidationUser(pathFB: "EnrollAuthentication") { result in
            
            self.isViewLoading.value = false
            switch result {
            case .success(let response):
                
                self.userCEObserver.value = response.data
                
            case .failure(let error):
                
                print(error)
                
                self.onMessageError.value = error
                
            }
        }
        
    }
    
    // MARK: - Update User
    
    func doUpdateInformation(update: InformationUserUpdate) {
        
        self.isViewLoading.value = true
        
        APIClient.updateUser(update: update) { result in
            
            self.isViewLoading.value = false
            
            switch result {
            case .success( _):
                
                
                self.userUpdated.value = "updateDone"
                
                
            case .failure(let error):
                
                print(error)
                self.onMessageError.value = error
            }
            
        }
        
    }
    
    
    // MARK: - Generate Code
    
    func doGenerateCode(post : GenerateCodePost) {
        
        self.isViewLoading.value = true
        
        APIClient.generateCode(post: post) { result in
            
            self.isViewLoading.value = false
            
            switch result {
            case .success( _):
                
                
                self.codeGenerated.value = post.sTipoNotificacion
                
                
            case .failure(let error):
                
                print(error)
                self.onMessageError.value = error
            }
            
        }
        
    }
    
    func doFirebaseGenerateCode() {
        
        self.isViewLoading.value = true
        
        APIClient.firebaseGenerateCode(pathFB: "EnrollGeneratePassword") { result in
            
            self.isViewLoading.value = false
            switch result {
            case .success(_):
                
                self.codeGenerated.value = "generated"
                
            case .failure(let error):
                
                print(error)
                
                self.onMessageError.value = error
                
            }
        }
        
    }
    
    // MARK: - Validated Code
    
    
    func doValidateCode(post: ValidationCodePost) {
        
        self.isViewLoading.value = true
        
        APIClient.validationCode(post: post) { result in
            
            self.isViewLoading.value = false
            
            switch result {
            case .success( _):
                
                self.codeValidated.value = true
                
                
                
            case .failure(let error):
                
                print(error)
                self.onValidateCodeError.value = error
                
            }
            
        }
        
    }
    
    
    func doFirebaseValidateCode() {
        
        self.isViewLoading.value = true
        
        APIClient.firebaseGenerateCode(pathFB: "EnrollValidate") { result in
            
            self.isViewLoading.value = false
            switch result {
            case .success(_):
                
                self.codeValidatedFirebase.value = true
                
            case .failure(let error):
                
                print(error)
                
                self.onMessageError.value = error
                
            }
        }
        
    }
}
