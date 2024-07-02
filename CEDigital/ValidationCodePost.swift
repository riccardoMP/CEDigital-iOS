//
//  letidationCodePost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/18/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation

struct ValidationCodePost: Codable {
    
    let sCodeDispositivo: String
    let sCodigo: String
    let sCorreo: String
    let sIntentos: Int
    let sTipoCodigo: String
    let uidPersona: String
    
}
