//
//  UpdatePasswordPost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/8/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation

struct UpdatePasswordPost: Codable {
    
    let sClave: String
    let sCodeDispositivo: String
    let sNumeroDoc: String
    let sNumeroTramite: String
    let tipoDocumento: String
    
}
