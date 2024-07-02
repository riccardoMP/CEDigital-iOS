//
//  UserRegisterPost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/18/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

struct UserRegisterPost: Codable {
    
    var sClave: String = ""
    var sCodeDispositivo: String = ""
    var sCodigo: String = ""
    var sCorreo: String = ""
    var sIdDocumento: String = ""
    var sNumero: String = ""
    var sNumeroDoc: String = ""
    var sSO: String = "IOS"
    var uidPersona: String = ""
    
}

class UserRegisterPostFluentBuilder {
    private var builder: UserRegisterPost
    
    
    init(builder: UserRegisterPost) {
        self.builder = builder
        
    }
    
    func setPassword(sClave: String) -> Self {
        self.builder.sClave = sClave
        
        return self
    }
    
    func setDeviceCode(sCodeDispositivo: String) -> Self {
        
        let uuidFormatted = sCodeDispositivo.replacingOccurrences(of: "-", with: "")
        
        var parametryCE = AppPreferences.init().parametryCEObject
        parametryCE.uuid = uuidFormatted
        
        AppPreferences.init().parametryCEObject = parametryCE
        
        
        self.builder.sCodeDispositivo  = sCodeDispositivo
        
        return self
    }
    
    func setValidationCode(sCodigoVerificacion: String) -> Self {
        self.builder.sCodigo = sCodigoVerificacion
        return self
    }
    
    func setEmail(sCorreo: String) -> Self {
        self.builder.sCorreo = sCorreo
        
        return self
    }
    
    func setIdDocument(sIdDocumento: String) -> Self {
        self.builder.sIdDocumento = sIdDocumento
        
        return self
    }
    
    func setPhone(sNumero: String) -> Self {
        self.builder.sNumero = sNumero
        
        return self
    }
    
    func setCarnetDoc(sNumeroDoc: String) -> Self {
        self.builder.sNumeroDoc = sNumeroDoc
        
        return self
    }
    
    func setUID(uidPersona: String) -> Self {
        self.builder.uidPersona = uidPersona
        
        return self
    }
    
    
    
    func build() -> UserRegisterPost {
        //do something else
        return self.builder
    }
    
    
}
