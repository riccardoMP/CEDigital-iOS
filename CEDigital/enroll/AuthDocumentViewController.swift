//
//  AuthDocumentViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 10/31/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit
import Combine

class AuthDocumentViewController: GenericViewController, ViewControllerProtocol {
    

    var coordinator: AuthenticationCoordinator?
    
    var imageDocument: String?
    
    var viewModel : AuthDocumentViewModel?
    var subscriber = Set<AnyCancellable>()
    
    @IBOutlet weak var iviDocument: UIImageView!
    @IBOutlet weak var eteMaterialDocument: CEFloatingPlaceholderTextField!
    @IBOutlet weak var butStart: UIButton!
    
    
    
    
    let typeEditText: TypeEditText = TypeEditText(typeDocument: .DOCUMENT)
    var registerPost = UserRegisterPostFluentBuilder(builder: UserRegisterPost())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        self.bindViewModel()   
    }
    
    
    override func viewDidLayoutSubviews() {
        

    }
    
    // MARK: - Method
    
    func initializeUI() {
        
        iviDocument.image = UIImage(named: imageDocument!)
        
        
        self.iviDocument.layer.cornerRadius = 15
        self.iviDocument.layer.masksToBounds = false
        iviDocument.layer.shadowColor = UIColor.black.cgColor
        iviDocument.layer.shadowOffset = CGSize(width: 4, height: 4)
        iviDocument.layer.shadowOpacity = 0.2
        iviDocument.layer.shadowRadius = 5.0
        
        
        
        butStart = ButtonFluentBuilder.init(button: butStart)
            .setBackground(UIParameters.COLOR_PRIMARY)
            .setTextColor(UIParameters.COLOR_WHITE)
            .setText("login_general".localized)
            .build()
        
        
    }
    
    func setup() {
        //eteMaterialDocument.textInput.text = "007889711"
        eteMaterialDocument.setup(typeEditText)
    }
    
    private func bindViewModel() {
        
        self.viewModel?.$userRegisterPost
            .compactMap({ $0 })
            .sink { [weak self] post in
                self?.coordinateToGeneratePassword(post: post)
            }.store(in: &subscriber)
        
        viewModel?.$errorMessage
            .compactMap({ $0 })
            .sink{ [weak self] message in
                guard !String.isNilOrEmpty(string: message) else {return}
                
                self?.showAlert(message: message)
            }
            .store(in: &subscriber)
        
        self.viewModel?.$errorTextField
            .compactMap({ $0 })
            .sink{ [weak self] message in
                guard !String.isNilOrEmpty(string: message) else {return}
                self?.eteMaterialDocument.setError(message)
            }.store(in: &subscriber)
        
        
        self.viewModel?.loadingState
            .sink { [weak self] state in
                self?.handleActivityIndicator(message: "general_loading".localized, state: state)
            }
            .store(in: &subscriber)
    }
    
    
    private func coordinateToGeneratePassword(post: UserRegisterPost){
        eteMaterialDocument.setError("")
        coordinator?.coordinateToGeneratePassword(registerPost: post)
    }
    /*func setupViewModel22(){
        
        viewModel.deviceInformation.bind { [weak self]  device in
            guard device != nil else { return }
            
            let numeroBusqueda = self?.eteMaterialDocument.textInput.text!
            let sCodeDispositivo = AppPreferences.shared.parametryCEObject.uuid
            let tipoBusqueda = self!.typeEditText.typeDocument.rawValue
            let tipoDocumento = self?.typeDocument!
            
            AppPreferences.shared.bearerToken = device
            
            
            let post = UserValidationPost(numeroBusqueda: numeroBusqueda!, sCodeDispositivo: sCodeDispositivo, tipoBusqueda: tipoBusqueda, tipoDocumento: tipoDocumento!)
            
            
            self?.viewModel.doValidationUser(post: post)
            
        }
        
        viewModel.userCEObserver.bind {  userCE in
            guard userCE != nil else { return }
            
            
            ParametryCEFluentBuilder(builder: AppPreferences.shared.parametryCEObject)
                .setDocumentNumber(documentNumber: userCE!.sNumeroCarnet)
                .setNumeroTramite(numeroTramite: userCE!.sNumeroTramite)
                .setUIDPersona(uidPersona: userCE!.uIdPersona)
                .setIdDocument(idDocumento: (self.typeDocument)!)
                .build()
            
            
            
            
            AppPreferences.shared.prefUserStored = AppUtils.encodeObject(userCE!)
            
            
            /*self.coordinator?.coordinateToBiometricFingerPrint(registerPost: self.registerPost
             .setEmail(sCorreo: userCE!.sEmail)
             .setPhone(sNumero: userCE!.sTelefono)
             .setIdDocument(sIdDocumento: (self.typeDocument)!)
             .setCarnetDoc(sNumeroDoc: userCE!.sNumeroCarnet)
             .setUID(uidPersona: userCE!.uIdPersona)
             .setDeviceCode(sCodeDispositivo: AppPreferences.shared.parametryCEObject.uuid)
             .build())*/
            
            
            /*self.coordinator?.coordinateToFacialValidation(registerPost: self.registerPost
             .setEmail(sCorreo: userCE!.sEmail)
             .setPhone(sNumero: userCE!.sTelefono)
             .setIdDocument(sIdDocumento: (self.typeDocument)!)
             .setCarnetDoc(sNumeroDoc: userCE!.sNumeroCarnet)
             .setUID(uidPersona: userCE!.uIdPersona)
             .setDeviceCode(sCodeDispositivo: AppPreferences.shared.parametryCEObject.uuid)
             .build())*/
            
            
            self.coordinator?.coordinateToGeneratePassword(registerPost: self.registerPost
                .setEmail(sCorreo: userCE!.sEmail)
                .setPhone(sNumero: userCE!.sTelefono)
                .setIdDocument(sIdDocumento: (self.typeDocument)!)
                .setCarnetDoc(sNumeroDoc: userCE!.sNumeroCarnet)
                .setUID(uidPersona: userCE!.uIdPersona)
                .setDeviceCode(sCodeDispositivo: AppPreferences.shared.parametryCEObject.uuid)
                .build())
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
    
    func isValid() -> Bool{
        var isValid = eteMaterialDocument.emptyValidate(message: "message_document_empty".localized)
        
        if(isValid){
            isValid = eteMaterialDocument.errorTextField(expression: typeEditText.regex, message: typeEditText.error)
        }
        
        return isValid
        
        
    }*/
    
    
    // MARK: - Action
    
    @IBAction func onValidateUser(_ sender: Any) {
        
        //(TimerApplication.shared as! TimerApplication).startSession()
        viewModel?.processPageData(documentNumber: eteMaterialDocument.textInput.text ?? "")
        
        /*if(isValid()){
            
            if(eteMaterialDocument.textInput.text! == Constants.APPLE_DOCUMENT_CE ){
                
                ParametryCEFluentBuilder(builder: AppPreferences.shared.parametryCEObject)
                    .isAppleUser(isAppleUser: true)
                    .build()
                
                self.viewModel.doFirebaseValidationUser()
            }else{
                
                ParametryCEFluentBuilder(builder: AppPreferences.shared.parametryCEObject)
                    .isAppleUser(isAppleUser: false)
                    .build()
                
                let post = DeviceInformationPost(sCodigo: RSAKeyManager.shared.getMyPublicKeyString()!,
                                                 sNumero: eteMaterialDocument.textInput.text!,
                                                 sTipo: self.typeDocument!)
                
                self.viewModel.doDeviceInformation(post: post)
            }
            
            
        }*/
    }
    
}

