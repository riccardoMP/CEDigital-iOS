//
//  LoginPost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation

struct LoginPost: Codable {
    let sClave: String
    let sCodeDispositivo: String
    let sNumeroDoc: String
    let sNumeroTramite: String
    let tipoDocumento: String
    var sSO: String = "IOS"
}

