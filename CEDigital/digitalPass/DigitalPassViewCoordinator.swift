//
//  DigitalPassViewCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol DigitalPassFlow: AnyObject {
    func coordinateToDetail()
}

class DigitalPassViewCoordinator: Coordinator, DigitalPassFlow {
    
    weak var navigationController: UINavigationController?
    var userLogin : UserLogin
    
    init(navigationController: UINavigationController, userLogin : UserLogin) {
        self.navigationController = navigationController
        self.userLogin = userLogin
    }
    
    func start() {
        let digitalPassViewController = DigitalPassViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        digitalPassViewController.coordinator = self
        digitalPassViewController.userLogin = userLogin
        
        navigationController?.pushViewController(digitalPassViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail() {
        //let topRatedDetailCoordinator = TopRatedDetailCoordinator(navigationController: navigationController!)
        //coordinate(to: topRatedDetailCoordinator)
    }
}
