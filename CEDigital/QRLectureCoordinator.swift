//
//  QRLectureCoordinator.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

protocol QRLectureFlow: AnyObject {
    func coordinateToDetail()
}

class QRLectureCoordinator: Coordinator, QRLectureFlow {
    
    weak var navigationController: UINavigationController?
    var userLogin : UserLogin
    
    init(navigationController: UINavigationController, userLogin : UserLogin) {
        self.navigationController = navigationController
        self.userLogin = userLogin
    }
    
    func start() {
        let qrLectureViewController = QRLectureViewController.instantiate(storyboard: StoryboardConstants.SB_PASS)
        qrLectureViewController.coordinator = self
        qrLectureViewController.userLogin = userLogin
        
        navigationController?.pushViewController(qrLectureViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail() {
        //let topRatedDetailCoordinator = TopRatedDetailCoordinator(navigationController: navigationController!)
        //coordinate(to: topRatedDetailCoordinator)
    }
}
