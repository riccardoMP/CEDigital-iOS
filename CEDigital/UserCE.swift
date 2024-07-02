//
//  UserCE.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation

struct UserCE: Codable {
    
    let sNumeroCarnet: String
    let sNumeroTramite: String
    let uIdPersona: String
    let sNombre: String
    let sPaterno: String
    let sMaterno: String
    let sEmail: String
    let sTelefono: String
    let dFechaNacimiento: String
    let bAnulado: Bool
    let dFechaVenc: String
    let dFechaAnulacion: String?
    
}
