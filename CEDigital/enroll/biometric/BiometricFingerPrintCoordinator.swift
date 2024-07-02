//
//  BiometricFingerPrintCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 4/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

protocol BiometricFingerPrintFlow: AnyObject {
    func coordinateToBiometricFaceValidation(registerPost: UserRegisterPost)
    func coordinateToPopUp(viewController: GenericViewController, delegate: PopUpResponseProtocol, biometricPopUp: BiometricLecturePopUp)
    
}

class BiometricFingerPrintCoordinator: Coordinator {
    let navigationController: UINavigationController
    let registerPost: UserRegisterPost
    
    init(navigationController: UINavigationController, registerPost: UserRegisterPost) {
        self.navigationController = navigationController
        self.registerPost = registerPost
    }
    
    func start() {
        
        let vc = BiometricFingerPrintViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self
        vc.registerPost = registerPost
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}

extension BiometricFingerPrintCoordinator : BiometricFingerPrintFlow {
    func coordinateToBiometricFaceValidation(registerPost: UserRegisterPost) {
        let startCoordinator = FacialRecognitionValidateCoordinator(navigationController: navigationController, registerPost: registerPost)
        coordinate(to: startCoordinator)
        
    }
    
    func coordinateToPopUp(viewController: GenericViewController, delegate: PopUpResponseProtocol, biometricPopUp: BiometricLecturePopUp) {
        let vc = BiometricResultPopUpViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.biometricPopUp = biometricPopUp
        vc.delegatePopUp = delegate
        
        viewController.present(vc, animated: true, completion: nil)
        
    }
    
}

