//
//  UserLogin.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

class UserLogin: Codable {
    
    let bAnulado: Bool
    let bduplicado: Bool
    let dFechaAnulacion: String?
    let dFechaCaducidad: String
    let dFechaEmision: String
    let dFechaInscripcion: String
    let dFechaNacimiento: String
    let dFechaVenc: String
    let maxUsoVerificacion: String?
    let sSiglaCalidad: String?
    let sCalidadMigratoria: String
    let sDepartamentoUbigeo: String
    let sDistritoUbigeo: String
    let sDomicilio: String
    let sEmail: String?
    var sFirmaPersona: String
    var sFirmaAutorizada: String
    var sFotoPersona: String
    var sHuellaPersona: String
    let sIdDocIdentidad: String
    let sIdEstadoCivil: String
    let sMaterno: String
    let sNombre: String
    let sNombreDedo: String
    let sNumDocIdentidad: String
    let sNumeroCarnet: String
    let sNumeroTramite: String?
    let sPaisNacimiento: String
    let sNacionalidad: String
    let sPaterno: String
    let sProvinciaUbigeo: String
    let sSexo: String
    let sTelefono: String?
    let sTipoTramite: String?
    let sUltimoTramiteMigra: String?
    let uIdPersona: String
    let sMRZFilaA: String
    let sMRZFilaB: String
    let sMRZFilaC: String?
    let sURL: String
    let sURLQR: String
    let sLugarExpedicion: String?
    let sEncriptado: String
    let sEstadoTramite: String
    
    var listMRZA : [String]?
    var listMRZB : [String]?
    var listMRZC : [String]?
    var dataFirmaPersona: Data?
    var dataFotoPersona: Data?
    var dataHuellaPersona: Data?
    var dataFirmaAutorizada: Data?
    
    let mensajeAdvertencia: UserLoginDisclaimer?
    
    func generateDataImage(){
        // Sign
        self.dataFirmaPersona =  Data.init(base64Encoded: sFirmaPersona, options: .init(rawValue: 0))
        self.sFirmaPersona = ""
        
        // Photo
        self.dataFotoPersona =  Data.init(base64Encoded: sFotoPersona, options: .init(rawValue: 0))
        self.sFotoPersona = ""
        
        //FingerPrint
        self.dataHuellaPersona =  Data.init(base64Encoded: sHuellaPersona, options: .init(rawValue: 0))
        self.sHuellaPersona = ""
        
        //Sign Auth
        self.dataFirmaAutorizada =  Data.init(base64Encoded: sFirmaAutorizada, options: .init(rawValue: 0))
        self.sFirmaAutorizada = ""
        
        self.listMRZA = self.sMRZFilaA.map({ String($0) })
        
        
        self.listMRZB = self.sMRZFilaB.map({ String($0) })
        
        if let mrzC = self.sMRZFilaC{
            self.listMRZC = mrzC.map({ String($0) })
        }
        
    }
}
