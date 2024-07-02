//
//  SeeMoreCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/30/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

protocol SeeMoreFlow: AnyObject {
    func coordinateToLogin()
    func coordinateToAuthDocument()
}

class SeeMoreCoordinator: Coordinator, SeeMoreFlow {
    
    weak var navigationController: UINavigationController?
    var userLogin : UserLogin
    
    init(navigationController: UINavigationController, userLogin : UserLogin) {
        self.navigationController = navigationController
        self.userLogin = userLogin
    }
    
    func start() {
        let seeMoreViewController = SeeMoreViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        seeMoreViewController.coordinator = self
        seeMoreViewController.userLogin = userLogin
        
        navigationController?.pushViewController(seeMoreViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToLogin() {
        let loginCoordinator = LoginCoordinator()
        coordinate(to: loginCoordinator)
    }
    
    func coordinateToAuthDocument() {
        let startCoordinator = AuthenticationCoordinator()
        coordinate(to: startCoordinator)
     
    }
}
