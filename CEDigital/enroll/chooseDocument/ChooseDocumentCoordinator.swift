//
//  ChooseDocumentCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol ChooseDocumentFlow: AnyObject {
    func coordinateToAuthentication(registerPost: UserRegisterPost)
}

class ChooseDocumentCoordinator: Coordinator, ChooseDocumentFlow {
    let window: UIWindow?
    var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    init() {
        self.window = nil
    }
    
    
    func start() {
        
        
        let vc = ChooseDocumentViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self
        
        navigationController = UINavigationController(rootViewController: vc)
        
        if (window != nil){
            window!.rootViewController = navigationController
        }else{
            UIApplication.shared.keyWindowInConnectedScenes?.rootViewController = navigationController
        }
        
        
        
        
    }
    
    // MARK: - Flow Methods
    func coordinateToAuthentication(registerPost: UserRegisterPost) {
        //let authCoordinator = AuthenticationCoordinator()
        //coordinate(to: authCoordinator)
    }
}

