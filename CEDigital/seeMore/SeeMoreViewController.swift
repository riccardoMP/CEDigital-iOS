//
//  SeeMoreViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/30/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class SeeMoreViewController: GenericViewController, ViewControllerProtocol {
    
    private let loginViewModel = LoginViewModel()
    var coordinator: SeeMoreFlow?
    var userLogin: UserLogin?
    
    @IBOutlet weak var vSeeMore: UIView!
    @IBOutlet weak var lblSetup: UILabel!
    @IBOutlet weak var lblSetupDescription: UILabel!
    
    @IBOutlet weak var vUnLink: TitleActionView!
    @IBOutlet weak var vAbout: TitleActionView!
    @IBOutlet weak var vLogout: TitleActionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        self.setupViewModel()
        

    }
    
    // MARK: - Method
    func initializeUI() {
        
        self.titleNavigationBar(title: AppPreferences.init().parametryCEObject.nameDocument)
        
        lblSetup = LabelFluentBuilder.init(label: lblSetup)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("more_configuration".localized)
            .setTextSize(16, UIParameters.TTF_BOLD)
            .build()
        
        lblSetupDescription = LabelFluentBuilder.init(label: lblSetupDescription)
            .setTextColor(#colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1))
            .setText("more_setup_description".localized)
            .setTextSize(14, UIParameters.TTF_LIGHT)
            .build()
        
        vUnLink.initializeUI(title: "more_unlink_account".localized)
        vAbout.initializeUI(title: "more_about".localized)
        vLogout.initializeUI(title: "general_logout".localized)
        
        
        
        //self.vSeeMore.layer.masksToBounds = true
        self.vSeeMore.layer.cornerRadius = 8
        self.vSeeMore.layer.borderWidth = 1
        self.vSeeMore.layer.borderColor = UIParameters.COLOR_GRAY_PASS.cgColor
        
        //self.vSeeMore.layer.masksToBounds = false
        
    }
    
    func setup() {
        vUnLink.addTapGestureRecognizer {
            self.showAlertUnlinkDevice()
        }
        
        vAbout.addTapGestureRecognizer {
            AppUtils.openURL(url: Constants.MIGRACIONES_WEB)
        }
        
        vLogout.addTapGestureRecognizer {
            self.showAlertLogout()
        }
        
    }
    
    func setupViewModel(){
        
        loginViewModel.unlinkDeviceObserver.bind { unlinkedDevice in
            
            guard unlinkedDevice != nil else { return }
            
            
            (TimerApplication.shared as! TimerApplication).stopTimer()
            
            ParametryCEFluentBuilder(builder: AppPreferences.init().parametryCEObject)
                .cleanParametry()
                .build()
            
            self.coordinator!.coordinateToAuthDocument()
        }
        
        
        loginViewModel.onMessageError.bind {  error in
            guard error != nil else { return }
            
            
            self.showMsgAlert(title: "general_oops".localized, message: error!.body, dismissAnimated: true)
            
            
        }
        
        
        loginViewModel.isViewLoading.bind { isViewLoading in
            guard isViewLoading != nil else { return }
            
            
            if(isViewLoading!){
                LoadingIndicatorView.show("general_loading".localized)
            }else{
                LoadingIndicatorView.hide()
            }
            
        }
    }
    
    func showAlertUnlinkDevice() {
        let alert = UIAlertController(title: "general_want_continue".localized, message: "general_unlink_device".localized, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "general_no".localized, style: UIAlertAction.Style.destructive, handler: { _ in
            
            
        }))
        alert.addAction(UIAlertAction(title: "general_yes".localized,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        
                                        if(AppPreferences.init().parametryCEObject.isAppleUser){
                                            self.loginViewModel.doFirebaseUnLinkDevice()
                                        }else{
                                            self.loginViewModel.doUnLinkDevice()
                                        }
                                        
                                        
                                        
                                        
                                        
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertLogout() {
        let alert = UIAlertController(title: "general_want_continue".localized, message: "general_logout_device".localized, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "general_no".localized, style: UIAlertAction.Style.destructive, handler: { _ in
            
            
        }))
        alert.addAction(UIAlertAction(title: "general_yes".localized,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        
                                        (TimerApplication.shared as! TimerApplication).stopTimer()
                                        self.coordinator?.coordinateToLogin()
                                        
                                        
                                        
                                        
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
