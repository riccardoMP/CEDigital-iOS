//
//  RecoveryValidateCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/8/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit

protocol RecoveryValidateFlow: AnyObject {
    func coordinateToSuccess()
    
}

class RecoveryValidateCoordinator: Coordinator, RecoveryValidateFlow {
    let navigationController: UINavigationController

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    
    }
    
    func start() {
        
        let vc = RecoveryValidateViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        vc.coordinator = self
    
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: - Flow Methods
 
    func coordinateToSuccess() {
        let recoveryCoordinator = RecoverySuccessCoordinator(navigationController: self.navigationController)
        coordinate(to: recoveryCoordinator)
     
    }
}
