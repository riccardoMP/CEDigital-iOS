//
//  SplashViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/16/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit
import SwiftyRSA
import Combine

class SplashViewController: GenericViewController, ViewControllerProtocol {
    
    let buildCode = Bundle.main.versionCode
    let buildNumber = Bundle.main.versionNumber
    
    var coordinator: AppCoordinator?
    
    var viewModel : SplashViewModel?
    var subscriber = Set<AnyCancellable>()
    
    @IBOutlet weak var vHeightCell: UIView!
    @IBOutlet weak var lblVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        setup()
        bindViewModel()
        
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
        viewModel?.generateUUID()
        viewModel?.doValidationNetwork()
    }
    
    private func bindViewModel() {
        viewModel?.$errorMessage
            .compactMap({ $0 })
            .sink{ [weak self] message in
                guard !String.isNilOrEmpty(string: message) else {return}
                
                self?.showInternetAlert(message: message)
            }
            .store(in: &subscriber)
        
        self.viewModel?.$deviceValidated
            .compactMap({ $0 })
            .sink { [weak self] isDeviceValid in
                self?.coordinateSplashTo(isDeviceValid: isDeviceValid)
            }.store(in: &subscriber)
        
        
        self.viewModel?.loadingState
            .sink { [weak self] state in
                self?.handleActivityIndicator(message: "general_loading".localized, state: state)
            }
            .store(in: &subscriber)
    }
    
    func showInternetAlert(message: String) {
        let alert = UIAlertController(title: "general_oops".localized, message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "general_ok".localized,
                                      style: .default,
                                      handler: {(_: UIAlertAction!) in
            self.viewModel?.doValidationNetwork()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func coordinateSplashTo(isDeviceValid : Bool){
        if(isDeviceValid) {
            coordinator?.coordinateToLogin()
        }else{
            coordinator?.coordinateToEnroll()
        }
    }
    
}
