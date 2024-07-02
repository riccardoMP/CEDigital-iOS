//
//  LoginCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/26/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol LoginFlow: AnyObject {
    func coordinateToMenu(userLogin : UserLogin)
    func coordinateToAuthentication()
    func coordinateToRecoveryInformation()
}

class LoginCoordinator: Coordinator, LoginFlow {
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
        
        
        let vc = LoginViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        vc.coordinator = self
        vc.showDialogLogout = self.showDialogLogout ?? false
        
        navigationController = UINavigationController(rootViewController: vc)
        
        if (window != nil){
            window!.rootViewController = navigationController
        }else{
            UIApplication.shared.keyWindowInConnectedScenes?.rootViewController = navigationController
        }
        
   
    }
    
    // MARK: - Flow Methods
    func coordinateToMenu(userLogin : UserLogin) {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController!, userLogin: userLogin)
        coordinate(to: tabBarCoordinator)
    }
    
    func coordinateToAuthentication() {
        let startCoordinator = AuthenticationCoordinator()
        coordinate(to: startCoordinator)
     
    }
    
    func coordinateToRecoveryInformation() {
        let recoveryCoordinator = RecoveryInformationCoordinator(navigationController: navigationController!)
        coordinate(to: recoveryCoordinator)
    }
}

