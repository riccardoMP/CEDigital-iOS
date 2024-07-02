//
//  PersonValidatePost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public struct PersonValidatePost: Codable {
    
    var dFechaNacimiento: String = ""
    var sCorreoElectronico: String = ""
    var sIdDocumento: String = ""
    var sIdEstadoCivil: String = ""
    var sIdPaisNacimiento: String = ""
    var sIdPaisNacionalidad: String = ""
    var sIdPaisResidencia: String = ""
    var sIdPersona: String = ""
    var sIdProfesion: String = ""
    var sMaterno: String = ""
    var sNombres: String = ""
    var sNumeroDocumento: String = ""
    var sPaterno: String = ""
    var sSexo: String = ""
    
    
    static func createPersonValidatePost(user : UserCE) -> PersonValidatePost{
        
        return PersonValidatePostFluentBuilder(builder: PersonValidatePost())
            .setFechaNacimiento(dFechaNacimiento: user.dFechaNacimiento.decrypt())
            .setCorrelElectronico(sCorreoElectronico: user.sEmail.decrypt())
            .setIdDocumento(sIdDocumento:  "PAS")
            .setIdPersona(sIdPersona: user.uIdPersona.decrypt())
            .setNumeroDocumento(sNumeroDocumento: user.sNumeroCarnet.decrypt())
            .build()
        
    }
    
    
}

class PersonValidatePostFluentBuilder {
    private var builder: PersonValidatePost
    
    
    init(builder: PersonValidatePost) {
        self.builder = builder
        
    }
    
    func setFechaNacimiento(dFechaNacimiento: String) -> Self {
        self.builder.dFechaNacimiento = dFechaNacimiento
        
        return self
    }
    
    func setCorrelElectronico(sCorreoElectronico: String) -> Self {
        self.builder.sCorreoElectronico = sCorreoElectronico
        
        return self
    }
    
    func setIdDocumento(sIdDocumento: String) -> Self {
        self.builder.sIdDocumento = sIdDocumento
        
        return self
    }
    
    func setIdPersona(sIdPersona: String) -> Self {
        self.builder.sIdPersona = sIdPersona
        
        return self
    }
    
    func setNumeroDocumento(sNumeroDocumento: String) -> Self {
        self.builder.sNumeroDocumento = sNumeroDocumento
        
        return self
    }
    
    
    
    
    
    func build() -> PersonValidatePost {
        //do something else
        return self.builder
    }
    
    
}
