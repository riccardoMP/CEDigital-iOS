//
//  RecoveryInformationCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/8/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit

protocol RecoveryInformationFlow: AnyObject {
    func coordinateToValidate()
}

class RecoveryInformationCoordinator: Coordinator, RecoveryInformationFlow {
    let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        
        let vc = RecoveryInformationViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        vc.coordinator = self
        
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToValidate() {
        
        let recoveryCoordinator = RecoveryValidateCoordinator(navigationController: self.navigationController)
        coordinate(to: recoveryCoordinator)
    }
}
