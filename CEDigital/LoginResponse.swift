//
//  LoginResponse.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation

struct LoginResponse: Codable {
    
    let codigo: String
    let mensaje: String
    let data: UserLogin
    
}
