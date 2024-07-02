//
//  BaseViewModel.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 10/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public class BaseViewModel {
    
    let isViewLoading: Box<Bool?> = Box(nil)
    let onMessageLoading: Box<Bool?> = Box(nil)
    let onMessageError: Box<NetworkMessage?> = Box(nil)
    let onNetworkError: Box<String?> = Box(nil)
    let refreshTokenObserver: Box<Bool?> = Box(nil)
    
    let viewWithStringLoading: Box<String?> = Box(nil)

    func doRefreshToken() {
        

        self.isViewLoading.value = true
        
        APIClient.refreshToken { result in
            
            self.isViewLoading.value = false
            
            switch result {
            case .success( let response):
                
                self.refreshTokenObserver.value = response
                
                
            case .failure(let error):
                
                print(error)
                self.onMessageError.value = error
            }
            
        }
    }
    
}

