//
//  GenerateCodeByPicker.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 15/11/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit


class GenerateCodeByPicker: NSObject {
    
    static let shared = GenerateCodeByPicker()
    fileprivate var currentVC: UIViewController!
    var actionBlock: ((EnumValidateBy) -> Void)?
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        
        
        let actionSheet = UIAlertController(title: "gp_disclaimer_validate".localized, message: nil, preferredStyle: .actionSheet)
        
        
        //SMS
        let actionSMS = UIAlertAction(title: "gp_sms".localized, style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.actionBlock?(EnumValidateBy.SMS)
            
            
        })
        actionSMS.setValue(UIImage(named: "ic_sms"), forKey: "image")
        actionSheet.addAction(actionSMS)
        
        //Email
        let actionEmail = UIAlertAction(title: "gp_mail".localized, style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.actionBlock?(EnumValidateBy.MAIL)
        })
        actionEmail.setValue(UIImage(named: "ic_mail"), forKey: "image")
        actionSheet.addAction(actionEmail)
        
        //Testing
        //Used to send a SMS to default value in the server
        if(Environment.enviroment == "general_development".localized){
            
            let actionTesting = UIAlertAction(title: "gp_test".localized, style: .default, handler: { (alert:UIAlertAction!) -> Void in
                self.actionBlock?(EnumValidateBy.TEST)
            })
            actionTesting.setValue(UIImage(named: "ic_sms"), forKey: "image")
            actionSheet.addAction(actionTesting)
        }
        
        
        
        actionSheet.addAction(UIAlertAction(title: "general_cancel".localized, style: .cancel, handler: nil))
        
        
        //if iPhone
        if UIDevice.isPhone  {
            currentVC.present(actionSheet, animated: true, completion: nil)
            
        }else{
            //In iPad Change Rect to position Popover
            actionSheet.popoverPresentationController?.sourceRect = currentVC.view.frame
            actionSheet.popoverPresentationController?.sourceView = currentVC.view
            
            currentVC.present(actionSheet, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    
    
    
}

