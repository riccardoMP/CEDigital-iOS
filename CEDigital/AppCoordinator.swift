//
//  AppCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

protocol AppFlow: AnyObject {
    func coordinateToEnroll()
    func coordinateToLogin()
}

class AppCoordinator: Coordinator, AppFlow {
    
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    func start() {
        let vc = SplashViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self
        vc.viewModel = SplashViewModel()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    // MARK: - Flow Methods
    
    func coordinateToEnroll() {
        
        let startCoordinator = AuthenticationCoordinator(window: window)
        coordinate(to: startCoordinator)
    }
    
    func coordinateToLogin() {
        
        let startCoordinator = LoginCoordinator(window: window)
        coordinate(to: startCoordinator)
    }
}
