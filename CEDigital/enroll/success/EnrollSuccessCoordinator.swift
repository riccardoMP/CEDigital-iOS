//
//  EnrollSuccessCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 12/11/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

protocol EnrollSuccessFlow: AnyObject {
    func coordinateToLogin()
    
}

class EnrollSuccessCoordinator: Coordinator, EnrollSuccessFlow {
    let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        
        let vc = EnrollSuccessViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self
        
        
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToLogin() {
        
        let loginCoordinator = LoginCoordinator()
        coordinate(to: loginCoordinator)
    }
}

