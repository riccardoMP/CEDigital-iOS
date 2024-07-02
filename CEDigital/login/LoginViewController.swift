//
//  LoginViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/26/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

class LoginViewController: GenericViewController, ViewControllerProtocol {
    
    
    private let loginViewModel = LoginViewModel()
    var coordinator: LoginCoordinator?
    var showDialogLogout:Bool?
    
    @IBOutlet weak var eteDocument: CEFloatingPlaceholderTextField!
    @IBOutlet weak var etePassword: CEFloatingPlaceholderTextField!
    
    
    @IBOutlet weak var butLogin: UIButton!
    @IBOutlet weak var butRecovery: UIButton!
    @IBOutlet weak var butEnrollAgain: UIButton!
    @IBOutlet weak var vEnrollAgain: UIView!
    
    
    
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
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtils.lockOrientation(.all)
    }
    
    // MARK: - Method
    
    func initializeUI() {
        
        self.titleNavigationBar(title: AppPreferences.init().parametryCEObject.nameDocument)
        
        
        //login_document_number
        
        butLogin = ButtonFluentBuilder.init(button: butLogin)
            .setBackground(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            .setText("login_general".localized)
            .build()
        
        
        butRecovery = ButtonFluentBuilder.init(button: butRecovery)
            .setBackground(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("login_recovery_password".localized)
            .setTextSize(13)
            .build()
        
        butEnrollAgain = ButtonFluentBuilder.init(button: butEnrollAgain)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("login_enroll_again".localized)
            .setTextSize(13, UIParameters.TTF_BOLD)
            .build()
        
        if(Environment.enviroment.isEmpty){
            vEnrollAgain.removeFromSuperview()
        }
        
        
    }
    
    
    
    func setup() {
        
        eteDocument.setup(TypeEditText(typeDocument: .DISABLE_DOCUMENT), .DISABLE)
        eteDocument.textInput.text = AppPreferences.init().parametryCEObject.documentNumber
        
        etePassword.setupForPassword(TypeEditText(typeDocument: .PASSWORD))
        
        if(showDialogLogout ?? false){
            showMsgAlert(title: "general_oops".localized, message: "general_session_logout".localized, dismissAnimated: false)
        }
        
    }
    
    func setupViewModel(){
        
        loginViewModel.deviceInformation.bind { [weak self]  device in
            guard device != nil else { return }
            
            let password = self?.etePassword.textInput.text!
            
            let loginPost = LoginPost(sClave: password!,
                                      sCodeDispositivo: AppPreferences.init().parametryCEObject.uuid,
                                      sNumeroDoc: AppPreferences.init().parametryCEObject.documentNumber,
                                      sNumeroTramite: AppPreferences.init().parametryCEObject.numeroTramite.decrypt(),
                                      tipoDocumento: AppPreferences.init().parametryCEObject.idDocumento)
            
            self?.loginViewModel.doLoginUser(post: loginPost)
            
        }
        
        loginViewModel.userLoginObserver.bind {[weak self]  userLogin in
            
            guard userLogin != nil else { return }
            
            
            //Setup Parametry
            var parametryCE = AppPreferences.init().parametryCEObject
            parametryCE.isUserEnrolled = true
            
            AppPreferences.init().parametryCEObject = parametryCE
            
            
            let  userLogin = userLogin
            userLogin!.generateDataImage()
            
            self?.coordinator!.coordinateToMenu(userLogin: userLogin!)
        }
        
        loginViewModel.loginFirebaseObserver.bind {[weak self]  userLogin in
            
            guard userLogin != nil else { return }
            
            
            
            let  userLogin = userLogin
            userLogin!.generateDataImage()
            
            self?.coordinator!.coordinateToMenu(userLogin: userLogin!)
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
    
    func isValid() -> Bool{
        let typePassword = TypeEditText(typeDocument: .PASSWORD)
        etePassword.setError("")
        
        var isValid = etePassword.errorTextField(expression: typePassword.regex, message: typePassword.error)
        
        
        if(isValid){
            isValid = etePassword.emptyValidate(message: "message_password_empty".localized)
        }
        
        
        return isValid
        
    }
    
    // MARK: - Action
    @IBAction func onLogin(_ sender: Any) {
        
        if(isValid()){
            
            if(AppPreferences.init().parametryCEObject.isAppleUser){
                self.loginViewModel.doFirebaseLoginUser()
            }else{
                let post = DeviceInformationPost(sCodigo: RSAKeyManager.shared.getMyPublicKeyString()!, sNumero: AppPreferences.init().parametryCEObject.documentNumber, sTipo: AppPreferences.init().parametryCEObject.idDocumento)
                
                self.loginViewModel.doDeviceInformation(post: post)
            }
            
        }
        
    }
    
    @IBAction func onRecoveryPassword(_ sender: Any) {
        self.coordinator!.coordinateToRecoveryInformation()
    }
    
    @IBAction func onEnrollAgain(_ sender: Any) {
        
        ParametryCEFluentBuilder(builder: AppPreferences.init().parametryCEObject)
            .cleanParametry()
            .build()
        self.coordinator!.coordinateToAuthentication()
    }
    
    
    
}
