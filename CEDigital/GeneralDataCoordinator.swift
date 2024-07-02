//
//  GeneralDataCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol GeneralDataFlow: AnyObject {
    func coordinateToDetail()
}

class GeneralDataCoordinator: Coordinator, GeneralDataFlow {
    
    weak var navigationController: UINavigationController?
    var userLogin : UserLogin
    
    init(navigationController: UINavigationController, userLogin : UserLogin) {
        self.navigationController = navigationController
        self.userLogin = userLogin
    }
    
    func start() {
        let generalDataViewController = GeneralDataViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        generalDataViewController.coordinator = self
        generalDataViewController.userLogin = userLogin
        
        navigationController?.pushViewController(generalDataViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail() {
        //let topRatedDetailCoordinator = TopRatedDetailCoordinator(navigationController: navigationController!)
        //coordinate(to: topRatedDetailCoordinator)
    }
}
