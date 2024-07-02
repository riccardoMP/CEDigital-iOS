//
//  GeneratePasswordCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol GeneratePasswordFlow: AnyObject {
    func coordinateToValidateCode(registerPost: UserRegisterPost, validateBy: EnumValidateBy)
    func coordinateToPopUpTermsCondition(generateViewController : GeneratePasswordViewController)
    func coordinateToAuthentication()
    func coordinateToUpdateInformation(viewController: UIViewController, delegate: UpdateInformationProtocol)
}

class GeneratePasswordCoordinator: Coordinator {
    let navigationController: UINavigationController
    let registerPost: UserRegisterPost
    
    init(navigationController: UINavigationController, registerPost: UserRegisterPost) {
        self.navigationController = navigationController
        self.registerPost = registerPost
    }
    
    func start() {
        
        let vc = GeneratePasswordViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self
        vc.registerPost = registerPost
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    
    
}

extension GeneratePasswordCoordinator : GeneratePasswordFlow {
    
    func coordinateToValidateCode(registerPost: UserRegisterPost, validateBy: EnumValidateBy) {
        let validateCodeCoordinator = ValidateCodeCoordinator(navigationController: navigationController, registerPost: registerPost, validateBy: validateBy)
        coordinate(to: validateCodeCoordinator)
    }
    
    func coordinateToPopUpTermsCondition(generateViewController : GeneratePasswordViewController) {
        
        let vc = TermsConditionViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        generateViewController.present(vc, animated: true, completion: nil)
    }
    
    func coordinateToAuthentication() {
        let startCoordinator = AuthenticationCoordinator(showDialogLogout: true)
        coordinate(to: startCoordinator)
        
    }
    
    func coordinateToUpdateInformation(viewController: UIViewController, delegate: UpdateInformationProtocol) {
        let startCoordinator = UpdateInformationCoordinator(viewControllerParent: viewController, delegate: delegate)
        coordinate(to: startCoordinator)
        
    }
}
