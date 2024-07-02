//
//  BiometricFingerPrintViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 4/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit
import Lottie
import Photos

class BiometricFingerPrintViewController: GenericViewController, ViewControllerProtocol {
    
    
    var coordinator : BiometricFingerPrintCoordinator?
    var registerPost: UserRegisterPost?
    
    private let viewModel = BiometricViewModel()
    
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var lblSteps: UILabel!
    @IBOutlet weak var lanFingerPrint: LottieAnimationView!
    @IBOutlet weak var lblStartFingerPrint: UILabel!
    @IBOutlet weak var lblDisclaimer: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.titleNavigationBar(title: "biometric_title".localized)
        
        self.initializeUI()
        self.setup()
        self.setupViewModel()
        
        
    }
    
    // MARK: - Method
    func initializeUI() {
        
        lanFingerPrint.contentMode = .scaleAspectFit
        lanFingerPrint.loopMode = .loop
        lanFingerPrint.animationSpeed = 0.4
        lanFingerPrint.play()
        
        
        
        lblHello = LabelFluentBuilder.init(label: lblHello)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText("biometric_hello".localizeWithFormat(arguments: AppPreferences.shared.getUser().sNombre))
            .setTextSize(18, UIParameters.TTF_REGULAR)
            .build()
        
        lblSteps = LabelFluentBuilder.init(label: lblSteps)
            .setTextColor(UIParameters.COLOR_GRAY_TEXT)
            .setText("biometric_step".localized)
            .setTextSize(14, UIParameters.TTF_REGULAR)
            .build()
        
        lblStartFingerPrint = LabelFluentBuilder.init(label: lblStartFingerPrint)
            .setTextColor(UIParameters.COLOR_GRAY_BORDER)
            .setText("biometric_verify".localized)
            .setTextSize(16, UIParameters.TTF_BOLD)
            .build()
        
        lblDisclaimer = LabelFluentBuilder.init(label: lblDisclaimer)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText("biometric_disclaimer".localized)
            .setTextSize(12, UIParameters.TTF_LIGHT)
            .build()
    }
    
    func setup() {
        (TimerApplication.shared as! TimerApplication).startSession()
        
        AppUtils.enableUIViewAsButton(view: lanFingerPrint, selector: #selector(onStart4FingerSDK), vc: self)
        AppUtils.enableUIViewAsButton(view: lblStartFingerPrint, selector: #selector(onStart4FingerSDK), vc: self)
    }
    
    
    func setupViewModel(){
        
        viewModel.fingerPrintValidated.bind {  device in
            guard device != nil else { return }
            
            self.coordinator?.coordinateToPopUp(viewController: self, delegate: self, biometricPopUp: BiometricLecturePopUp(title: "general_oops".localized, description: "biometric_success_description".localized, butAction: "general_continue".localized, image: "ic_success", resultEnum: .SUCCESS))
            
        }
        
        
        viewModel.onMessageError.bind {  error in
            guard error != nil else { return }
            
            
            self.coordinator?.coordinateToPopUp(viewController: self, delegate: self, biometricPopUp: BiometricLecturePopUp(title: "general_oops".localized, description: error!.body, butAction: "general_back".localized, image: "ic_error", resultEnum: .ERROR))
            
        }
        
        
        viewModel.isViewLoading.bind { isViewLoading in
            guard isViewLoading != nil else { return }
            
            
            if(isViewLoading!){
                LoadingIndicatorView.show("biometric_validating".localized)
            }else{
                LoadingIndicatorView.hide()
            }
            
        }
    }
    
    // MARK: - Notification
    
    @objc func onStart4FingerSDK(sender: UITapGestureRecognizer){
        
        FourFingerSDK.init(delegate: self, viewController: self).checkForCameraPermission()
        
        guard let fileUrl = Bundle.main.url(forResource: "FingerPrintDummy", withExtension: "json") else {
         print("File could not be located at the given url")
         return
         }
         
         do {
         let jsonData = try Data(contentsOf: fileUrl)
         
         let post = try JSONDecoder().decode(FingerPrintValidatePost.self, from: jsonData)
         
         
         viewModel.doValidationFingerPrintIdentity(post: post)
         
         } catch {
         
         }
        
        
    }
    
    
}


extension BiometricFingerPrintViewController : PopUpResponseProtocol {
    
    func onPopUpSuccess() {
        coordinator?.coordinateToBiometricFaceValidation(registerPost: self.registerPost!)
    }
    
    func onPopUpError() {
        
    }
    
}


extension BiometricFingerPrintViewController : FourFingerProtocol {
    
    
    
    func onFourFingerProcessed(arrayBiometric: [BiometricPost], photoAudit: String) {
        
        let post = FingerPrintValidatePost(biometriaHuellas: arrayBiometric, fotoHuellas: photoAudit, persona: PersonValidatePost.createPersonValidatePost(user: AppPreferences.shared.getUser()))
        
        viewModel.doValidationFingerPrintIdentity(post: post)
        
        
        
    }
    
    
    func onFourFingerFailure(message: String) {
        coordinator?.coordinateToPopUp(viewController: self, delegate: self, biometricPopUp: BiometricLecturePopUp(title: "general_oops".localized, description: message, butAction: "general_back".localized, image: "ic_error", resultEnum: .ERROR))
    }
    
    
}
