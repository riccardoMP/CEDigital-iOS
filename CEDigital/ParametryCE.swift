//
//  ParametryCE.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/26/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit


struct ParametryCE: Codable {
    
    var idDocumento: String = "" // CE o PPT
    var nameDocument: String = "" // CARNÉ EXTRANJERÍA DIGITAL o PERMISO TEMPORAL DE PERMANENCIA
    var titleAccess: String = "" // CARNÉ DE EXTRANJERÍA  o PERMISO TEMPORAL DE PERMANENCIA
    var documentNumber: String = ""
    var numeroTramite: String = ""
    var isUserEnrolled: Bool = false
    var isAppleUser: Bool = false
    var uuid: String = ""
    var uidPersona: String = ""
    
    
}

class ParametryCEFluentBuilder {
    private var builder: ParametryCE
    
    
    init(builder: ParametryCE) {
        self.builder = builder
        
    }
    
    func setIdDocument(idDocumento: String) -> Self {
        self.builder.idDocumento = idDocumento
        self.builder.nameDocument = (idDocumento == Constants.DOCUMENT_TYPE_CE) ? "general_ce_digital".localized : "general_ptp_digital".localized
        self.builder.titleAccess = (idDocumento == Constants.DOCUMENT_TYPE_CE) ? "auth_access_ce".localized : "auth_access_ptp".localized
        
        
        return self
    }
    
    func setDocumentNumber(documentNumber: String) -> Self {
        
        self.builder.documentNumber = documentNumber
        
        return self
    }
    
    func setNumeroTramite(numeroTramite: String) -> Self {
        self.builder.numeroTramite = numeroTramite
        return self
    }
    
    func isUserEnrolled(isUserEnrolled: Bool) -> Self {
        self.builder.isUserEnrolled = isUserEnrolled
        
        return self
    }
    
    func isAppleUser(isAppleUser: Bool) -> Self {
        self.builder.isAppleUser = isAppleUser
        
        return self
    }
    
    func setUUID(uuid: String) -> Self {
        self.builder.uuid = uuid
        
        return self
    }
    
    func setUIDPersona(uidPersona: String) -> Self {
        self.builder.uidPersona = uidPersona
        
        return self
    }
    
    func cleanParametry() -> Self {
        self.builder.titleAccess = ""
        self.builder.idDocumento = ""
        self.builder.documentNumber = ""
        self.builder.uidPersona = ""
        self.builder.isUserEnrolled = false
        self.builder.isAppleUser = false
        self.builder.numeroTramite = ""
        
        return self
    }
    
    
    
    func build(){
        //do something else
        
        AppPreferences.init().parametryCEObject = self.builder
        
    }
    
    
}
