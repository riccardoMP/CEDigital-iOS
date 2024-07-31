//
//  GeneratePasswordViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit
import ActiveLabel

class GeneratePasswordViewController: GenericViewController, ViewControllerProtocol {
    
    private let viewModel = EnrollViewModel()
    var coordinator: GeneratePasswordFlow?
    
    @IBOutlet weak var tviUserData: TextImageHView!
    @IBOutlet weak var tviPassword: TextImageHView!
    @IBOutlet weak var vName: LectureView!
    @IBOutlet weak var vPhone: LectureView!
    @IBOutlet weak var vMail: LectureView!
    @IBOutlet weak var etePassword: CEFloatingPlaceholderTextField!
    @IBOutlet weak var eteRepeatPassword: CEFloatingPlaceholderTextField!
    
    @IBOutlet weak var butCheckbox: CheckBoxView!
    @IBOutlet weak var lblTermsCondition: ActiveLabel!
    @IBOutlet weak var butGenerate: UIButton!

    
    var typeEditText: TypeEditText = TypeEditText(typeDocument: .PASSWORD)
    var registerPost: UserRegisterPost?
    
    
    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.doActionEditInformation(_:)), name: .actionImage, object: nil)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .actionImage, object: nil)
        
        
    }
    
    // MARK: - Method
    
    func initializeUI() {
        
        self.delegate = self
        self.titleNavigationBar(title: "gp_title".localized)
        
        
        tviUserData.initializeUI(title: "gp_user_data".localized, image: "ic_person")
        tviPassword.initializeUI(title: "gp_password".localized, image: "ic_shield")
        
        let user = AppPreferences.shared.getUser()
        
        vName.initializeUI(title: "gd_names".localized, description: "\(user.sNombre) \(user.sPaterno) \(user.sMaterno)")
        
        if(AppPreferences.shared.parametryCEObject.isAppleUser){
            vPhone.initializeUI(title: "general_phone".localized, description: user.sTelefono.maskingText(expression: Constants.REGEX_MASKING_PHONE))
            vMail.initializeUI(title:"general_email".localized , description: user.sEmail.maskingText(expression: Constants.REGEX_MASKING_EMAIL))
        }else{
            vPhone.initializeUI(title: "general_phone".localized, description: user.sTelefono.decrypt().maskingText(expression: Constants.REGEX_MASKING_PHONE))
            vMail.initializeUI(title:"general_email".localized , description: user.sEmail.decrypt().maskingText(expression: Constants.REGEX_MASKING_EMAIL))
        }
        
        
        lblTermsCondition = LabelFluentBuilder.init(label: lblTermsCondition)
            .setTextColor(UIParameters.COLOR_GRAY_LOGIN)
            .setText("gp_terms_condition".localized)
            .setTextSize(12, UIParameters.TTF_BOLD)
            .build() as? ActiveLabel
        
        butGenerate = ButtonFluentBuilder.init(button: butGenerate)
            .setBackground(UIParameters.COLOR_PRIMARY)
            .setTextColor(UIParameters.COLOR_WHITE)
            .setText("gp_generate_password".localized)
            .build()
        
    }
    
    func setup() {
        self.setupActiveLabel()
        
        etePassword.setupForPassword(typeEditText)
        
        typeEditText.hint = "gp_hint_repeat".localized
        eteRepeatPassword.setupForPassword(typeEditText)
    }
    
    
    func setupViewModel(){
        viewModel.codeGenerated.bind {  validateBy in
            guard validateBy != nil else { return }
            
            self.registerPost = UserRegisterPostFluentBuilder(builder: self.registerPost!)
                .setPassword(sClave: self.etePassword.textInput.text!)
                .build()
            
            
            self.coordinator?.coordinateToValidateCode(registerPost: self.registerPost!)
        }
        
        //2. Observer when the WS response the person information
        viewModel.userCEObserver.bind {  userCE in
            guard userCE != nil else { return }
            
            
        
            self.registerPost = UserRegisterPostFluentBuilder(builder: self.registerPost!)
                .setEmail(sCorreo: userCE!.sEmail)
                .setPhone(sNumero: userCE!.sTelefono)
                .build()
            
            AppPreferences.shared.prefUserStored = AppUtils.encodeObject(userCE!)
            
            
            self.vPhone.setDescription(value: userCE!.sTelefono.decrypt().maskingText(expression: Constants.REGEX_MASKING_PHONE))
            self.vMail.setDescription(value: userCE!.sEmail.decrypt().maskingText(expression: Constants.REGEX_MASKING_EMAIL))
            
        }
        
        viewModel.onMessageError.bind {  error in
            guard error != nil else { return }
            
            self.showMsgAlert(title: "general_oops".localized, message: error!.body, dismissAnimated: true)
            
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
    
    func setupActiveLabel( ){
        
        let customType = ActiveType.custom(pattern: "\\s\("gp_terms_condition_keyword".localized)\\b")
        
        lblTermsCondition.enabledTypes = [ customType]
        lblTermsCondition.customize { label in
            
            lblTermsCondition.numberOfLines = 0
            lblTermsCondition.customColor[customType] = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
            
            lblTermsCondition.handleCustomTap(for: customType) { _ in
                
                self.coordinator?.coordinateToPopUpTermsCondition(generateViewController: self)
                
                
            }
        }
    }
    
    func isValid() -> Bool{
        
        etePassword.setError("")
        eteRepeatPassword.setError("")
        
        var isValid = etePassword.emptyValidate(message: "message_password_empty".localized)
        
        if(isValid){
            isValid = etePassword.errorTextField(expression: typeEditText.regex, message: typeEditText.error)
        }
        
        if(isValid){
            isValid = eteRepeatPassword.emptyValidate(message: "message_password_empty".localized)
        }
        
        if(isValid){
            isValid = {
                switch ( etePassword.textInput.text == eteRepeatPassword.textInput.text) {
                case true:
                    return true
                case false: do {
                    eteRepeatPassword.setError("gp_dialog_error_password".localized)
                    return false
                }
                
                }
            }()
        }
        
        if(isValid){
            isValid = {
                switch ( butCheckbox.isChecked) {
                case true:
                    return true
                case false: do {
                    self.showMsgAlert(title: "general_oops".localized, message: "gp_dialog_error_terms_condition".localized, dismissAnimated: true)
                    return false
                }
                
                }
            }()
        }
        
        return isValid
        
    }
    
    
    // MARK: - Action
    
    @IBAction func onValidatePassword(_ sender: Any) {
        
        if(isValid()){
            if(AppPreferences.shared.parametryCEObject.isAppleUser){
                self.viewModel.doFirebaseGenerateCode()
            }else{
                self.doGenerateCode()
            }
            
        }
    }
    
    // MARK: - Notification
    
    @objc func doActionEditInformation(_ notification:Notification){
        coordinator?.coordinateToUpdateInformation(viewController: self, delegate: self)
    }
    
    // MARK: - WebService
    
    func doGenerateCode() {

        let generateCode = GenerateCodePost(sCodeDispositivo: registerPost!.sCodeDispositivo
                                            , sCodigo: ""
                                            , sCorreo: registerPost!.sCorreo.decrypt()
                                            , sIntentos: 1
                                            , sTipoCodigo: AppUtils.EnumTypeCodeUser.VERIFICATION.rawValue
                                            , uidPersona: registerPost!.uidPersona.decrypt()
                                            , sTelefono: AppPreferences.shared.getUser().sTelefono.decrypt()
                                            , sTipoNotificacion: EnumValidateBy.MAIL.rawValue)
        
        
        viewModel.doGenerateCode(post: generateCode)
    }
    
}

extension GeneratePasswordViewController : LogoutProtocol{
    func onLogout() {
        coordinator?.coordinateToAuthentication()
    }
}

extension GeneratePasswordViewController : UpdateInformationProtocol{
    func onUpdateSuccess() {
        let post = UserValidationPost(numeroBusqueda: AppPreferences.shared.parametryCEObject.documentNumber, sCodeDispositivo: AppPreferences.shared.parametryCEObject.uuid, tipoBusqueda: EnumTypeEditText.DOCUMENT.rawValue, tipoDocumento: AppPreferences.shared.parametryCEObject.idDocumento)
        
        
        self.viewModel.doValidationUser(post: post)
    }
    
    
    
    
}

