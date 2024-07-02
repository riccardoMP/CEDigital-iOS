//
//  UserValidationResponse.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation

struct UserValidationResponse: Codable {
    
    let codigo: String
    let mensaje: String
    let data: UserCE
    
}

