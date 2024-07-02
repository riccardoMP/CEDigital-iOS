//
//  TypeDocument.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/16/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

struct TypeEditText: Codable  {
    
    
    var code: String = ""
    var typeDocument: EnumTypeEditText
    var length: Int = 0
    var typeKeyboard: Int = UIKeyboardType.default.rawValue
    var regex: String = ""
    var hint: String = ""
    var error: String = ""
    
    // MARK: - Intialization
    init( typeDocument:EnumTypeEditText) {
        self.init(code: "", typeDocument: typeDocument)
        
    }
    init(code:String, typeDocument:EnumTypeEditText) {
        
        self.code = code
        self.typeDocument = typeDocument
        switch typeDocument {
        case .DOCUMENT:
            self.length = 9
            self.typeKeyboard = UIKeyboardType.numberPad.rawValue
            self.regex = Constants.REGEX_DOCUMENT
            self.hint = "auth_hint_document".localized
            self.error = "auth_error_document".localized
            
        case .PROCEDURE:
            self.length = 11
            self.typeKeyboard = UIKeyboardType.default.rawValue
            self.regex = Constants.REGEX_PROCEDURE
            self.hint = "auth_hint_procedure".localized
            self.error = "auth_error_procedure".localized
            
        case .PASSWORD:
            self.length = 16
            self.typeKeyboard = UIKeyboardType.default.rawValue
            self.regex = Constants.REGEX_PASSWORD
            self.hint = "gp_hint_generate".localized
            self.error = "login_password_error".localized
            
        case .REPEAT_PASSWORD:
            self.length = 16
            self.typeKeyboard = UIKeyboardType.default.rawValue
            self.regex = Constants.REGEX_PASSWORD
            self.hint = "gp_hint_repeat".localized
            self.error = "login_password_error".localized
            
        case .VALIDATE_CODE:
            self.length = 6
            self.typeKeyboard = UIKeyboardType.default.rawValue
            self.regex = Constants.REGEX_CODE
            self.hint = "vc_hint".localized
            self.error = "vc_error".localized
            
            
        case .DISABLE_DOCUMENT:
            self.hint = "login_document_number".localized
            break
            
        
        }
    }
    
    
    
}


