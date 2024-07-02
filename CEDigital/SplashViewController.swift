//
//  SplashViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/16/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit
import SwiftyRSA

class SplashViewController: GenericViewController, ViewControllerProtocol {
    
    
    
    let buildCode = Bundle.main.versionCode
    let buildNumber = Bundle.main.versionNumber
    
    var coordinator: AppCoordinator?
    
    @IBOutlet weak var vHeightCell: UIView!
    @IBOutlet weak var lblVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.initializeUI()
        self.setup()
        
        
        /*
         //To get public key.
         let myPublicKey = RSAKeyManager.shared.getMyPublicKey()
         let myPrivateKey = RSAKeyManager.shared.getMyPrivateKey()
         //To get public key string that can share with others.
         let myPublicKeyString = RSAKeyManager.shared.getMyPublicKeyString()
         
         
         //generate key public from string
         let otherPublicKey = RSAKeyManager.shared.getMyPublicKeyString(pemEncoded: myPublicKeyString!)
         
         var encryptedMessageString: String = ""
         //Encrypt Message (Using other's public key)
         do {
         let message: String = "Hi, Ross"
         let clear = try ClearMessage(string: message, using: .utf8)
         
         let encryptedMessage = try clear.encrypted(with: otherPublicKey!, padding: .PKCS1)
         encryptedMessageString = encryptedMessage.base64String
         
         let xd = ""
         } catch _ {
         let ddxd = ""
         }
         
         
         
         //Decrypt Message (Which encrypted using my public key)
         do {
         
         let myPrivateKey = RSAKeyManager.shared.getMyPrivateKey()
         let encrypted = try EncryptedMessage(base64Encoded: encryptedMessageString)
         let clear = try encrypted.decrypted(with: myPrivateKey!, padding: .PKCS1)
         let string = try clear.string(encoding: .utf8)
         
         let xd = ""
         } catch _ {
         //Log error
         let ddxd = ""
         }
         
         */
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        AppPreferences.init().prefHeightCell = Float(self.vHeightCell.bounds.height)
        
        
    }
    
    // MARK: - Method
    func initializeUI() {
        lblVersion = LabelFluentBuilder.init(label: lblVersion)
            .setTextColor(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))
            .setText("v\(buildCode!) \(Environment.enviroment)")
            .setTextSize(18, UIParameters.TTF_REGULAR)
            .build()
    }
    
    func setup() {
        
        self.doValidationNetwork()
        
        if(AppPreferences.init().parametryCEObject.uuid.isEmpty){
            ParametryCEFluentBuilder(builder: AppPreferences.init().parametryCEObject)
                .setUUID(uuid: UUID().uuidString.replacingOccurrences(of: "-", with: ""))
                
                .build()
        }
        
        
        
    }
    
    func showAlertForward() {
        let alert = UIAlertController(title: "general_oops".localized, message: "generic_description_no_internet".localized, preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "general_ok".localized,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        self.doValidationNetwork()
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func doValidationNetwork(){
        NetworkManager.isUnreachable { _ in
            DispatchQueue.main.async {
                self.showAlertForward()
            }
        }
        
        NetworkManager.isReachable { _ in
            if(AppPreferences.init().parametryCEObject.isUserEnrolled && AppPreferences.init().parametryCEObject.isAppleUser){
                self.coordinator?.coordinateToLogin()
            }else{
                
                self.doValidateDevice()
            }
            
        }
    }
    
    // MARK: - WebService
    
    func doValidateDevice() {
        
        
        LoadingIndicatorView.show("vc_loading_register".localized)
        
        
        APIClient.validateDevice(post: ValidateDevicePost(sCodigoDispositivo: AppPreferences.init().parametryCEObject.uuid, uIdPersona: AppPreferences.init().parametryCEObject.uidPersona)) { result in
            
            
            switch result {
            case .success( let response):
                
                if(AppPreferences.init().parametryCEObject.isUserEnrolled && response.data){
                    self.coordinator?.coordinateToLogin()
                }else{
                    
                    self.coordinator?.coordinateToEnroll()
                }
                
                
                
            case .failure(let error):
                LoadingIndicatorView.hide()
                
                
                switch error.httpCode {
                case SP.HTTP_CODE.BAD_REQUEST, SP.HTTP_CODE.UNAUTHORIZED:
                    
                    self.coordinator?.coordinateToEnroll()
                    
                    
                default:
                    //self.showAlertForward()
                    self.coordinator?.coordinateToEnroll()
                    
                }
                
            }
            
        }
    }
}
