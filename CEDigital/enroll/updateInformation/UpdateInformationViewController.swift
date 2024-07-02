//
//  UpdateInformationViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 1/12/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

class UpdateInformationViewController: GenericViewController, ViewControllerProtocol {
    
    
    
    private let viewModel = EnrollViewModel()
    
    var delegateUpdate : UpdateInformationProtocol?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDisclaimer: UILabel!
    @IBOutlet weak var tteEmail: CETitleTextField!
    @IBOutlet weak var ttePhone: CETitleTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.initializeUI()
        self.setup()
        self.setupViewModel()
        
        
        
    }
    
    
    // MARK: - Method
    
    func initializeUI() {
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText("gp_sheet_title".localized)
            .setTextSize(18, UIParameters.TTF_BOLD)
            .build()
        
        lblDisclaimer = LabelFluentBuilder.init(label: lblDisclaimer)
            .setTextColor(UIParameters.COLOR_GRAY_ONBOARDING)
            .setText("gp_sheet_disclaimer".localized)
            .setTextSize(12, UIParameters.TTF_REGULAR)
            .build()
        
        tteEmail.initializeUI(title: "general_email".localized, placeholder: "general_mail_hint".localized, keyboardType: .emailAddress)
        
        tteEmail.setValue(value: AppPreferences.shared.getUser().sEmail.decrypt())
        
        ttePhone.initializeUI(title: "general_phone".localized, placeholder: "general_phone_hint".localized, keyboardType: .phonePad, maxLenght: 9)
        
        ttePhone.setValue(value: AppPreferences.shared.getUser().sTelefono.decrypt())
        
        
    }
    
    func setup() {
        
        
        //Button Close
        let doneButton = UIBarButtonItem(title: "general_cancel".localized, style: .done, target: self, action: #selector(onClose))
        doneButton.tintColor = UIParameters.COLOR_WHITE
        navigationItem.leftBarButtonItem = doneButton
        
        
        //Button Add Update
        let addButton = UIBarButtonItem(title: "general_update".localized, style: .done, target: self, action: #selector(onUpdateInformation))
        addButton.tintColor = UIParameters.COLOR_WHITE
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    
    func showAlertWantContinue() {
        let alert = UIAlertController(title: "general_message".localized, message: "gp_sheet_confirm".localized, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "general_no".localized, style: UIAlertAction.Style.destructive, handler: { _ in
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "general_yes".localized,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        
            self.viewModel.doUpdateInformation(update: InformationUserUpdate(sTelefono: self.ttePhone.getValue(), sCorreo: self.tteEmail.getValue(), uIdPersona: AppPreferences.shared.getUser().uIdPersona.decrypt()))
                                        
                                        
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertUpdateSuccess() {
        let alert = UIAlertController(title: "general_message".localized, message: "gp_sheet_update_success".localized, preferredStyle: UIAlertController.Style.alert)
        
        
        
        alert.addAction(UIAlertAction(title: "general_ok".localized,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            
            self.delegateUpdate?.onUpdateSuccess()
            self.dismiss(animated: true)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func isValid() -> (isValid: Bool, messageError: String) {
        
        
        var isValid = !(tteEmail.isEmpty())
        var messageError = "gp_sheet_email_empty".localized
        
        if(isValid){
            isValid = tteEmail.isExpresionValid(expression: Constants.REGEX_EMAIL)
            messageError = "gp_sheet_validate_email".localized
            
        }else{
            return (isValid, messageError)
        }
        
        
        if(isValid){
            isValid = !(ttePhone.isEmpty())
            messageError = "gp_sheet_phone_empty".localized
            
        }else{
            return (isValid, messageError)
        }
        
        if(isValid){
            isValid = ttePhone.isExpresionValid(expression: Constants.REGEX_PHONE)
            messageError = "gp_sheet_validate_phone".localized
            
        }else{
            return (isValid, messageError)
        }
        
        
        return (isValid, messageError)
        
    }
    
    // MARK: - ViewModel
    
    func setupViewModel(){
        
        viewModel.userUpdated.bind {   response in
            guard response != nil else { return }
            
            self.showAlertUpdateSuccess()
            
        }
        
        
        
        viewModel.onMessageError.bind {  error in
            guard error != nil else { return }
            
            
            self.showMsgAlert(title: "general_oops".localized, message: error!.body, dismissAnimated: true)
            
            
        }
        
        
        viewModel.isViewLoading.bind { isViewLoading in
            guard isViewLoading != nil else { return }
            
            
            if(isViewLoading!){
                LoadingIndicatorView.show("general_updating".localized)
            }else{
                LoadingIndicatorView.hide()
            }
            
        }
    }
    
   
    
    
    // MARK: - UIBarButtonItem event
    
    @objc func onClose(){
        
        dismiss(animated: true)
        
    }
    
    
    @objc func onUpdateInformation(){
        
        if(isValid().isValid){
            self.showAlertWantContinue()
        }else{
            self.showMsgAlert(title: "general_oops".localized, message: isValid().messageError, dismissAnimated: true)
        }
        
    }
    
    
    
    
}
