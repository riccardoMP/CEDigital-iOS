//
//  LoginViewModel.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 10/21/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Firebase

public class LoginViewModel : BaseViewModel {
    
    
    let deviceInformation: Box<String?> = Box(nil)
    let userLoginObserver: Box<UserLogin?> = Box(nil)
    let generateCodeObserver: Box<String?> = Box(nil)
    let loginFirebaseObserver: Box<UserLogin?> = Box(nil)
    let unlinkDeviceObserver: Box<Bool?> = Box(nil)
    
    
    
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
    
    
    
    
    func doGenerateCode(post: GenerateCodePost) {
        
        
        APIClient.generateCode(post: post) { result in
            
            LoadingIndicatorView.hide()
            
            switch result {
            case .success( let response):
                
                self.generateCodeObserver.value = response.mensaje
                
                
            case .failure(let error):
                
                print(error)
                self.onMessageError.value = error
            }
            
        }
    }
    
    // MARK: - Login
    
    func doLoginUser(post : LoginPost) {
        APIClient.loginUser(post: post) { result in
            
            self.isViewLoading.value = false
            
            switch result {
            case .success( let response):
                
                self.userLoginObserver.value = response.data
                
                
                
            case .failure(let error):
                print(error)
                
                self.onMessageError.value = error
            }
            
        }
        
    }
    
    func doFirebaseLoginUser() {
        
        self.isViewLoading.value = true
        
        APIClient.firebaseLogin(pathFB: "LoginUser") { result in
            
            self.isViewLoading.value = false
            switch result {
            case .success( let response):
                
                self.loginFirebaseObserver.value = response.data
                
            case .failure(let error):
                
                print(error)
                
                self.onMessageError.value = error
                
            }
        }
        
    }
    
    // MARK: - Unlink Device
    
    
    func doUnLinkDevice() {
        
        let unlinkPost = UnlinkDevicePost(sCodigoDispositivo: AppPreferences.init().parametryCEObject.uuid, uIdPersona: AppPreferences.init().parametryCEObject.uidPersona.decrypt())
        
        self.isViewLoading.value = true
        
        APIClient.unlinkDevice(post: unlinkPost) { result in
            
            self.isViewLoading.value = false
            
            switch result {
            case .success( _):
                
                self.unlinkDeviceObserver.value = true
                

            case .failure(let error):
                print(error)
                
                self.onMessageError.value = error
            }
            
        }
        
    }
    
    func doFirebaseUnLinkDevice() {
        
        
        self.isViewLoading.value = true
        
        APIClient.fireBaseUnlinkDevice(pathFB: "LoginUnlink") { result in
            
            self.isViewLoading.value = false
            
            switch result {
            case .success( _):
                
                self.unlinkDeviceObserver.value = true
                
                
                
                
            case .failure(let error):
                print(error)
                
                self.onMessageError.value = error
            }
            
        }
        
    }
    
}

