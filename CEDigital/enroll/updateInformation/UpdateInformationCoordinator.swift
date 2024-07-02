//
//  UpdateInformationCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 1/12/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit


class UpdateInformationCoordinator: Coordinator {
    
    let viewControllerParent: UIViewController
    var navigationControllerChild: UINavigationController?
    var delegate: UpdateInformationProtocol?
    
    
    init(viewControllerParent: UIViewController, delegate: UpdateInformationProtocol) {
        self.viewControllerParent = viewControllerParent
        self.navigationControllerChild = nil
        self.delegate = delegate
        

    }
    

    func start() {
        
        let vc = UpdateInformationViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .pageSheet
        vc.delegateUpdate = delegate
        
        navigationControllerChild = UINavigationController(rootViewController: vc)
        
        navigationControllerChild = UINavigationController(rootViewController: vc)
        navigationControllerChild!.modalTransitionStyle = .coverVertical
        navigationControllerChild!.modalPresentationStyle = .formSheet
        viewControllerParent.present(navigationControllerChild!, animated: true, completion: nil)
    
        
    }
    
    // MARK: - Flow Methods
    
}



