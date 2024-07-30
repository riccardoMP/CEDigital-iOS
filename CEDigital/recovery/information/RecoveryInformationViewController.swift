//
//  RecoveryInformationViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/8/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class RecoveryInformationViewController: GenericViewController, ViewControllerProtocol {
    
    private let loginViewModel = LoginViewModel()
    var coordinator: RecoveryInformationFlow?
    
    var notificationType: String = ""
    
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var vMail: LectureView!
    @IBOutlet weak var vPhone: LectureView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var butSendEmail: UIButton!
    @IBOutlet weak var lblDisclaimer: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initializeUI()
        self.setup()
        self.setupViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtils.lockOrientation(.portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtils.lockOrientation(.all)
    }
    
    func initializeUI() {
        
        self.titleNavigationBar(title: "recovery_title".localized)
        
        lblSubTitle = LabelFluentBuilder.init(label: lblSubTitle)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText("recovery_subtitle".localized)
            .setTextSize(13, UIParameters.TTF_BOLD)
            .build()
        lblSubTitle.layer.addBorder(edge: UIRectEdge.bottom, color: UIParameters.COLOR_SEPARATOR, thickness: 0.5)
        
        
        vPhone.initializeUI(title: "general_phone".localized, description: AppPreferences.shared.getUser().sTelefono.decrypt().maskingText(expression: Constants.REGEX_MASKING_PHONE))
        vMail.initializeUI(title:"general_email".localized , description: AppPreferences.shared.getUser().sEmail.decrypt().maskingText(expression: Constants.REGEX_MASKING_EMAIL))
        
        
        lblDescription = LabelFluentBuilder.init(label: lblDescription)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText("recovery_tip".localized)
            .setTextSize(12, UIParameters.TTF_REGULAR)
            .build()
        
        
        
        butSendEmail = ButtonFluentBuilder.init(button: butSendEmail)
            .setBackground(UIParameters.COLOR_PRIMARY)
            .setTextColor(UIParameters.COLOR_WHITE)
            .setText("gp_generate_password".localized)
            .build()
        
        lblDisclaimer = LabelFluentBuilder.init(label: lblDisclaimer)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText("recovery_disclaimer".localized)
            .setTextSize(13, UIParameters.TTF_LIGHT)
            .build()
    }
    
    func setup() {
        
    }
    
    func setupViewModel(){
        
        //1. Used to generate Bearer Token
        loginViewModel.deviceInformation.bind { [weak self]  device in
            guard device != nil else { return }
            
            self?.doGenerateCode()
            
        }
        
        //2. Used when the code was sent to the device
        loginViewModel.generateCodeObserver.bind {  success in
            
            guard success != nil else { return }
            
            
            self.coordinator!.coordinateToValidate()
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
    
    
    func doGenerateCode() {
        let generateCode = GenerateCodePost(sCodeDispositivo: AppPreferences.init().parametryCEObject.uuid
                                            , sCodigo: ""
                                            , sCorreo: AppPreferences.init().getUser().sEmail.decrypt()
                                            , sIntentos: 0
                                            , sTipoCodigo: AppUtils.EnumTypeCodeUser.ACCESS.rawValue
                                            , uidPersona: AppPreferences.init().getUser().uIdPersona.decrypt()
                                            , sTelefono: AppPreferences.shared.getUser().sTelefono.decrypt()
                                            , sTipoNotificacion: EnumValidateBy.MAIL.rawValue)
        
        
        self.loginViewModel.doGenerateCode(post: generateCode)
    }
    
    
    // MARK: - Action
    
    @IBAction func onValidateCode(_ sender: Any) {
        
        let post = DeviceInformationPost(sCodigo: RSAKeyManager.shared.getMyPublicKeyString()!, sNumero: AppPreferences.shared.parametryCEObject.documentNumber, sTipo: AppPreferences.shared.parametryCEObject.idDocumento)
        
        self.loginViewModel.doDeviceInformation(post: post)
    }
    
}
