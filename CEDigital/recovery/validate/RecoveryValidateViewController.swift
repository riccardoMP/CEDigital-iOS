//
//  RecoveryValidateViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/8/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

class RecoveryValidateViewController: GenericViewController, ViewControllerProtocol , UITextFieldDelegate {
    
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var etePassword: CEFloatingPlaceholderTextField!
    @IBOutlet weak var eteRepeatPassword: CEFloatingPlaceholderTextField!
    @IBOutlet weak var butUpdatePassword: UIButton!
    @IBOutlet weak var butSendAgain: UIButton!
    @IBOutlet weak var lblDisclaimer: UILabel!
    
    
    var otpCode = ""
    var countAttemps = 1
    
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
    
    var typeEditText: TypeEditText = TypeEditText(typeDocument: .PASSWORD)
    
    var coordinator: RecoveryValidateFlow?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initializeUI()
        self.setup()
        
        
    }
    
    // MARK: - Method
    
    func initializeUI() {
        
        self.titleNavigationBar(title: "recovery_title".localized)
        
        
        lblSubTitle = LabelFluentBuilder.init(label: lblSubTitle)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("recovery_subtitle_2".localized)
            .setTextSize(13, UIParameters.TTF_BOLD)
            .build()
        
        lblSubTitle.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), thickness: 0.5)
        
        
        butUpdatePassword = ButtonFluentBuilder.init(button: butUpdatePassword)
            .setBackground(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            .setText("general_update".localized)
            .build()
        
        butSendAgain = ButtonFluentBuilder.init(button: butSendAgain)
            .setBackground(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("general_send_again".localized)
            .build()
        
        lblDisclaimer = LabelFluentBuilder.init(label: lblDisclaimer)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("recovery_validate_disclaimer".localized)
            .setTextSize(13, UIParameters.TTF_LIGHT)
            .build()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtils.lockOrientation(.portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtils.lockOrientation(.all)
    }
    
    func setup() {
        etePassword.setupForPassword(TypeEditText(typeDocument: .PASSWORD))
        
        eteRepeatPassword.setupForPassword(TypeEditText(typeDocument: .REPEAT_PASSWORD))
        
        
    }
    
    func clearCodes(){
        self.txtCode1.text = ""
        self.txtCode2.text = ""
        self.txtCode3.text = ""
        self.txtCode4.text = ""
        self.txtCode5.text = ""
        self.txtCode6.text = ""
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
    
    func isValid() -> (isValid: Bool, messageError: String) {
        
        etePassword.setError("")
        eteRepeatPassword.setError("")
        
        var isValid = (!self.otpCode.isEmpty)
        var messageError = "vc_error_empty".localized
        
        if(isValid){
            isValid = (self.otpCode.count == 6)
            messageError = "Ingrese el código de 6 dígitos para finalizar la verificación."
            
        }else{
            return (isValid, messageError)
        }
        
        if(isValid){
            isValid = etePassword.emptyValidate(message: "message_password_empty".localized) && eteRepeatPassword.emptyValidate(message: "message_password_empty".localized)
            
        }
        
        if(isValid){
            isValid = etePassword.errorTextField(expression: typeEditText.regex, message: typeEditText.error)
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
        
        return (isValid, messageError)
        
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
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
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
    
    
    // MARK: - Action
    
    @IBAction func onValidateCode(_ sender: Any) {
        
        self.otpCode = "\(self.txtCode1.text!)\(self.txtCode2.text!)\(self.txtCode3.text!)\(self.txtCode4.text!)\(self.txtCode5.text!)\(self.txtCode6.text!)"
        
        if(isValid().isValid){
            self.doValidationcode()
        }else{
            self.showMsgAlert(title: "general_oops".localized, message: isValid().messageError, dismissAnimated: true)
        }
    }
    
    @IBAction func onSendAgain(_ sender: Any) {
        doGenerateCode()
    }
    
    
    // MARK: - WebService
    
    func doValidationcode() {
        
        
        let post = ValidationCodePost(sCodeDispositivo: AppPreferences.init().parametryCEObject.uuid
                                      , sCodigo: self.otpCode
                                      , sCorreo: AppPreferences.init().getUser().sEmail.decrypt()
                                      , sIntentos: self.countAttemps
                                      , sTipoCodigo: AppUtils.EnumTypeCodeUser.ACCESS.rawValue
                                      , uidPersona: AppPreferences.init().getUser().uIdPersona.decrypt())
        
        LoadingIndicatorView.show("recovery_updating_password".localized)
        
        APIClient.validationCode(post: post) { result in
            
            switch result {
            case .success( _):
                
                self.dopUpdatePassword()
                
                
                
            case .failure(let error):
                LoadingIndicatorView.hide()
                
                self.countAttemps += 1
                self.clearCodes()
                print(error)
                self.showMsgAlert(title: "general_oops".localized, message: error.body, dismissAnimated: true)
            }
            
        }
    }
    
    func dopUpdatePassword() {
        
        let post = UpdatePasswordPost(sClave: self.etePassword.textInput.text!
                                      , sCodeDispositivo: AppPreferences.init().parametryCEObject.uuid
                                      , sNumeroDoc: AppPreferences.init().parametryCEObject.documentNumber
                                      , sNumeroTramite: AppPreferences.init().parametryCEObject.numeroTramite.decrypt()
                                      , tipoDocumento: AppPreferences.init().parametryCEObject.idDocumento)
        
        
        APIClient.updatePassword(post: post) { result in
            
            LoadingIndicatorView.hide()
            
            switch result {
            case .success( _):
                
                self.coordinator?.coordinateToSuccess()
                
                
                
            case .failure(let error):
                LoadingIndicatorView.hide()
                
                print(error)
                self.showMsgAlert(title: "general_oops".localized, message: error.body, dismissAnimated: true)
            }
            
        }
    }
    
    func doGenerateCode() {
        LoadingIndicatorView.show("gp_loading".localized)
        
        
        let generateCode = GenerateCodePost(sCodeDispositivo: AppPreferences.init().parametryCEObject.uuid
                                            , sCodigo: ""
                                            , sCorreo: AppPreferences.init().getUser().sEmail.decrypt()
                                            , sIntentos: 0
                                            , sTipoCodigo: AppUtils.EnumTypeCodeUser.ACCESS.rawValue
                                            , uidPersona: AppPreferences.init().getUser().uIdPersona.decrypt()
                                            , sTelefono: AppPreferences.shared.getUser().sTelefono.decrypt()
                                            , sTipoNotificacion: EnumValidateBy.MAIL.rawValue)
        
        
        APIClient.generateCode(post: generateCode) { result in
            
            LoadingIndicatorView.hide()
            
            switch result {
            case .success( let response):
                
                self.countAttemps = 1
                self.showMsgAlert(title: "general_oops".localized, message: response.mensaje, dismissAnimated: true)
                
                
            case .failure(let error):
                
                print(error)
                self.showMsgAlert(title: "general_oops".localized, message: error.body, dismissAnimated: true)
            }
            
        }
    }
}

