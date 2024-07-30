//
//  ValidateCodeCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol ValidateCodeFlow: AnyObject {
    func coordinateToAuthentication()
    func coordinateToSuccessEnroll()
}

class ValidateCodeCoordinator: Coordinator {
    let navigationController: UINavigationController
    let registerPost: UserRegisterPost
    
    init(navigationController: UINavigationController, registerPost: UserRegisterPost) {
        self.navigationController = navigationController
        self.registerPost = registerPost
    }
    
    func start() {
        
        let vc = ValidateCodeViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self
        vc.registerPost = registerPost
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}

extension ValidateCodeCoordinator: ValidateCodeFlow {
    // MARK: - Flow Methods
    
    func coordinateToSuccessEnroll() {
        let coordinator = EnrollSuccessCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
    
    
    
    func coordinateToAuthentication() {
        let startCoordinator = AuthenticationCoordinator(showDialogLogout: true)
        coordinate(to: startCoordinator)
        
    }
}
