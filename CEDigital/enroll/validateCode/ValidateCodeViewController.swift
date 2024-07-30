//
//  ValidateCodeViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class ValidateCodeViewController: GenericViewController, ViewControllerProtocol , UITextFieldDelegate {
    
    private let viewModel = EnrollViewModel()
    var coordinator: ValidateCodeCoordinator?
    var countAttemps = 1
    
    
    @IBOutlet weak var lblDigits: UILabel!
    @IBOutlet weak var butValidate: UIButton!
    @IBOutlet weak var butSendAgain: UIButton!
    @IBOutlet weak var lblDisclaimer: UILabel!
    
    var otpCode = ""
    
    @IBOutlet weak var txtCode1: UITextField!{
        didSet{
            txtCode1.delegate = self
            txtCode1.tag = 1
            self.setupTextField(textField: txtCode1)
            
        }
    }
    
    @IBOutlet weak var txtCode2: UITextField!{
        didSet{
            txtCode2.delegate = self
            txtCode2.tag = 2
            self.setupTextField(textField: txtCode2)
            
        }
    }
    
    @IBOutlet weak var txtCode3: UITextField!{
        didSet{
            txtCode3.delegate = self
            txtCode3.tag = 3
            self.setupTextField(textField: txtCode3)
            
        }
    }
    @IBOutlet weak var txtCode4: UITextField!{
        didSet{
            txtCode4.delegate = self
            txtCode4.tag = 4
            self.setupTextField(textField: txtCode4)
            
        }
    }
    
    @IBOutlet weak var txtCode5: UITextField!{
        didSet{
            txtCode5.delegate = self
            txtCode5.tag = 5
            self.setupTextField(textField: txtCode5)
            
        }
    }
    
    @IBOutlet weak var txtCode6: UITextField!{
        didSet{
            txtCode6.delegate = self
            txtCode6.tag = 6
            self.setupTextField(textField: txtCode6)
            
        }
    }
    
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
    
    // MARK: - Method
    
    func initializeUI() {
        
        self.titleNavigationBar(title: "vc_title".localized)
        self.delegate = self
        
        lblDigits = LabelFluentBuilder.init(label: lblDigits)
            .setText("verification_digits_mail".localized)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setTextSize(13, UIParameters.TTF_REGULAR)
            .build()
        
        lblDigits.layer.addBorder(edge: UIRectEdge.top, color: #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), thickness: 0.5)
        lblDigits.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), thickness: 0.5)
        
        
        butValidate = ButtonFluentBuilder.init(button: butValidate)
            .setBackground(UIParameters.COLOR_PRIMARY)
            .setTextColor(UIParameters.COLOR_WHITE)
            .setText("vc_validate".localized)
            .build()
        
        
        butSendAgain = ButtonFluentBuilder.init(button: butSendAgain)
            .setBackground(UIParameters.COLOR_WHITE)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText("vc_send_again".localized)
            .build()
        
    }
    
    func setup() {
        
    }
    
    func setupViewModel(){
        
        viewModel.codeValidated.bind {  device in
            guard device != nil else { return }
            
            self.doRegisterUser()
            
        }
        
        
        viewModel.codeValidatedFirebase.bind {  device in
            guard device != nil else { return }
            
            (TimerApplication.shared as! TimerApplication).stopTimer()
            
            
            ParametryCEFluentBuilder(builder: AppPreferences.init().parametryCEObject)
                .isUserEnrolled(isUserEnrolled: true)
                .build()
            
            
            self.coordinator?.coordinateToSuccessEnroll()
            
        }
        
        
        
        viewModel.onValidateCodeError.bind {  error in
            guard error != nil else { return }
            
            self.countAttemps += 1
            self.clearCodes()
            self.showMsgAlert(title: "general_oops".localized, message: error!.body, dismissAnimated: true)
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
    
    private func setupTextField(textField: UITextField){
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIParameters.COLOR_GRAY_PASS.cgColor
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .default
        
        AppUtils.customPlaceHolderBulletPoint(textField: textField)
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    
    func clearCodes(){
        self.txtCode1.text = ""
        self.txtCode2.text = ""
        self.txtCode3.text = ""
        self.txtCode4.text = ""
        self.txtCode5.text = ""
        self.txtCode6.text = ""
    }
    
    func isValid() -> (isValid: Bool, messageError: String) {
        
        
        var isValid = (!self.otpCode.isEmpty)
        var messageError = "vc_error_empty".localized
        
        if(isValid){
            isValid = (self.otpCode.count == 6)
            messageError = "Ingrese el código de 6 dígitos para finalizar la verificación."
            
        }else{
            return (isValid, messageError)
        }
        
        return (isValid, messageError)
        
    }
    
    // MARK: - Action
    
    @IBAction func onValidateCode(_ sender: Any) {
        
        self.otpCode = "\(self.txtCode1.text!)\(self.txtCode2.text!)\(self.txtCode3.text!)\(self.txtCode4.text!)\(self.txtCode5.text!)\(self.txtCode6.text!)"
        
        if(isValid().isValid){
            if(AppPreferences.shared.parametryCEObject.isAppleUser){
                self.viewModel.doFirebaseValidateCode()
            }else{
                
                let post = ValidationCodePost(sCodeDispositivo: registerPost!.sCodeDispositivo
                                              , sCodigo: self.otpCode
                                              , sCorreo: registerPost!.sCorreo.decrypt()
                                              , sIntentos: self.countAttemps
                                              , sTipoCodigo: AppUtils.EnumTypeCodeUser.VERIFICATION.rawValue
                                              , uidPersona: registerPost!.uidPersona.decrypt())
                self.viewModel.doValidateCode(post: post)
            }
            
        }else{
            self.showMsgAlert(title: "general_oops".localized, message: isValid().messageError, dismissAnimated: true)
        }
        
        
    }
    
    @IBAction func onSendAgain(_ sender: Any) {
        self.doGenerateCode()
    }
    
    
    // MARK: - Delegates
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            if((textField.text?.count)! >= 1 ){
                nextField.becomeFirstResponder()
            }
            
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.count + string.count - range.length
        
        
        return newLength <= 1
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    
    // MARK: - WebService
    
    
    func doRegisterUser() {
        
        self.registerPost = UserRegisterPostFluentBuilder(builder: self.registerPost!)
            .setValidationCode(sCodigoVerificacion: self.otpCode)
            .build()
        
        //Decrypt object
        let registerPostDecrypted = UserRegisterPostFluentBuilder(builder: self.registerPost!)
            .setEmail(sCorreo: self.registerPost!.sCorreo.decrypt())
            .setPhone(sNumero: self.registerPost!.sNumero.decrypt())
            .setUID(uidPersona: self.registerPost!.uidPersona.decrypt())
            .build()
        
        
        APIClient.registerUser(post: registerPostDecrypted) { result in
            
            LoadingIndicatorView.hide()
            
            switch result {
            case .success( _):
                
                
                (TimerApplication.shared as! TimerApplication).stopTimer()
                
                
                ParametryCEFluentBuilder(builder: AppPreferences.init().parametryCEObject)
                    .isUserEnrolled(isUserEnrolled: true)
                    .build()
                
                self.coordinator?.coordinateToSuccessEnroll()
                
                
                
            case .failure(let error):
                LoadingIndicatorView.hide()
                
                print(error)
                self.showMsgAlert(title: "general_oops".localized, message: error.body, dismissAnimated: true)
            }
            
        }
    }
    
    func doGenerateCode() {
        
        LoadingIndicatorView.show("gp_loading".localized)
        
        
        let generateCode = GenerateCodePost(sCodeDispositivo: registerPost!.sCodeDispositivo
                                            , sCodigo: ""
                                            , sCorreo: registerPost!.sCorreo.decrypt()
                                            , sIntentos: 1
                                            , sTipoCodigo: AppUtils.EnumTypeCodeUser.VERIFICATION.rawValue
                                            , uidPersona: registerPost!.uidPersona.decrypt()
                                            , sTelefono: AppPreferences.shared.getUser().sTelefono.decrypt()
                                            , sTipoNotificacion: EnumValidateBy.MAIL.rawValue)
        
        
        APIClient.generateCode(post: generateCode) { result in
            
            LoadingIndicatorView.hide()
            
            switch result {
            case .success( let response):
                
                self.countAttemps = 1
                self.clearCodes()
                self.showMsgAlert(title: "general_oops".localized, message: response.mensaje, dismissAnimated: true)
                
                
            case .failure(let error):
                
                print(error)
                self.showMsgAlert(title: "general_oops".localized, message: error.body, dismissAnimated: true)
            }
            
        }
    }
    
    
}


extension ValidateCodeViewController : LogoutProtocol{
    func onLogout() {
        coordinator?.coordinateToAuthentication()
    }
}
