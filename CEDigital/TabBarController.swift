//
//  TabBarController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController  {
    
    var coordinator: TabBarCoordinator?
    private let viewModel = BaseViewModel()
    
    override func viewDidLoad() {
        
    
        
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = UIParameters.COLOR_PRIMARY
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIParameters.COLOR_WHITE]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIParameters.COLOR_WHITE]
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            
        } else {
            self.tabBar.layer.masksToBounds = true
            self.tabBar.barStyle = .black
            self.tabBar.barTintColor = UIParameters.COLOR_PRIMARY
            self.tabBar.tintColor = UIParameters.COLOR_WHITE
            self.tabBar.unselectedItemTintColor = UIParameters.COLOR_GRAY_ICON
            
            self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
            self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
            self.tabBar.layer.shadowRadius = 10
            self.tabBar.layer.shadowOpacity = 1
            self.tabBar.layer.masksToBounds = false
        }
        
        
        (TimerApplication.shared as! TimerApplication).startSession()
        
        self.setupViewModel()
    }
    
    
    func setupViewModel(){
        
        viewModel.refreshTokenObserver.bind {  device in
            guard device != nil else { return }
            
            (TimerApplication.shared as! TimerApplication).startSession()
            
        }
        
        viewModel.isViewLoading.bind { isViewLoading in
            guard isViewLoading != nil else { return }
            
            
            if(isViewLoading!){
                LoadingIndicatorView.show("general_loading".localized)
            }else{
                LoadingIndicatorView.hide()
            }
            
        }
    }
    
    
}

extension TabBarController: SessionProtocol {
    func onSessionWillExpire() {
        
        self.showGenericAlert(title: "general_oops".localized,
                              message: "general_session_will_expire".localized,
                              alertStyle: .alert,
                              actionTitles: ["general_yes".localized, "general_no".localized],
                              actionStyles: [.default, .cancel],
                              actions: [
                                {_ in
                                    self.viewModel.doRefreshToken()
                                },
                                { [self]_ in
                                    
                                    coordinator?.coordinateToLogin()
                                    
                                }
                              ])
    }
    
    func onSessionLogout() {
        coordinator?.coordinateToLogin()
    }
}
