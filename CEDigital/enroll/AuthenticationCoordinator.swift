//
//  AuthenticationCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol AuthenticationFlow: AnyObject {
    func coordinateToBiometricFingerPrint(registerPost: UserRegisterPost)
    func coordinateToFacialValidation(registerPost: UserRegisterPost)
    func coordinateToGeneratePassword(registerPost: UserRegisterPost)
}

class AuthenticationCoordinator: Coordinator {
    let window: UIWindow?
    let showDialogLogout: Bool?
    var navigationController: UINavigationController?
    
    init(window: UIWindow, showDialogLogout : Bool = false) {
        self.window = window
        self.showDialogLogout = showDialogLogout
    }
    
    init(showDialogLogout : Bool = false) {
        self.window = nil
        self.showDialogLogout = showDialogLogout
    }
    
    func start() {
        
        let vc = AuthenticationViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self
        vc.showDialogLogout = self.showDialogLogout!
        
        
        navigationController = UINavigationController(rootViewController: vc)
        
        if (window != nil){
            window!.rootViewController = navigationController
        }else{
            UIApplication.shared.keyWindowInConnectedScenes?.rootViewController = navigationController
        }
        
        
    }
    
    
}

extension AuthenticationCoordinator : AuthenticationFlow {
    func coordinateToBiometricFingerPrint(registerPost: UserRegisterPost) {
        
        let coordinator = BiometricFingerPrintCoordinator(navigationController: navigationController!, registerPost: registerPost)
        coordinate(to: coordinator)
    }
    
    func coordinateToFacialValidation(registerPost: UserRegisterPost) {
        
        
        let coordinator = FacialRecognitionValidateCoordinator(navigationController: navigationController!, registerPost: registerPost)
        coordinate(to: coordinator)
    }
    
    
    // MARK: - Flow Methods
    func coordinateToGeneratePassword(registerPost: UserRegisterPost) {
        let generateCoordinator = GeneratePasswordCoordinator(navigationController: navigationController!, registerPost: registerPost)
        coordinate(to: generateCoordinator)
    }
}
