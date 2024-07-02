//
//  RecoverySuccessCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/8/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

protocol RecoverySuccessFlow: AnyObject {
    func coordinateToLogin()
    
}

class RecoverySuccessCoordinator: Coordinator, RecoverySuccessFlow {
    let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        
        let vc = RecoverySuccessViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        vc.coordinator = self
        
        
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToLogin() {
        
        let loginCoordinator = LoginCoordinator()
        coordinate(to: loginCoordinator)
    }
}
