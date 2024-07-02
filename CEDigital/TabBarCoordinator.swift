//
//  TabBarCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

protocol TabFlow: AnyObject {
    func coordinateToLogin()
}

class TabBarCoordinator: Coordinator, TabFlow {
    
    let navigationController: UINavigationController
    let userLogin : UserLogin
    
    init(navigationController: UINavigationController, userLogin : UserLogin) {
        self.navigationController = navigationController
        self.userLogin = userLogin
    }
    
    func start() {
        
        
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        
        //Digital Pass
        let digitalPassNavigationController = UINavigationController()
        digitalPassNavigationController.tabBarItem = UITabBarItem(title: "bn_digital_pass".localized, image: UIImage(named: "ic_document_id"), tag: 0)
        
        let digitalPassCoordinator = DigitalPassViewCoordinator(navigationController: digitalPassNavigationController, userLogin: userLogin)
        
        //General Data
        let generalDataNavigationController = UINavigationController()
        generalDataNavigationController.tabBarItem = UITabBarItem(title: "bn_general_data".localized, image: UIImage(named: "ic_general_data"), tag: 1)
        let searchCoordinator = GeneralDataCoordinator(navigationController: generalDataNavigationController, userLogin: userLogin)
        
        //QR
        let qrLectureNavigationController = UINavigationController()
        qrLectureNavigationController.tabBarItem = UITabBarItem(title: "bn_qr".localized, image: UIImage(named: "ic_qr"), tag: 2)
        let qrCoordinator = QRLectureCoordinator(navigationController: qrLectureNavigationController, userLogin: userLogin)
        
        //See more
        let seeMoreNavigationController = UINavigationController()
        seeMoreNavigationController.tabBarItem = UITabBarItem(title: "bn_see_more".localized, image: UIImage(named: "ic_more"), tag: 3)
        let seeMoreCoordinator = SeeMoreCoordinator(navigationController: seeMoreNavigationController, userLogin: userLogin)
        
        tabBarController.viewControllers = [digitalPassNavigationController,
                                            generalDataNavigationController,
                                            qrLectureNavigationController,
                                            seeMoreNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to: digitalPassCoordinator)
        coordinate(to: searchCoordinator)
        coordinate(to: qrCoordinator)
        coordinate(to: seeMoreCoordinator)
    }
    
    func coordinateToLogin() {
        (TimerApplication.shared as! TimerApplication).stopTimer()
        
        let loginCoordinator = LoginCoordinator(showDialogLogout: true)
        coordinate(to: loginCoordinator)
    }
}
