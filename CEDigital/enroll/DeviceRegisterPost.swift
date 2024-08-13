//
//  DeviceRegisterPost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 31/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

struct DeviceRegisterPost: Codable {
    let code: String
    let documentNumber: String
    let documentType: String
    
    enum CodingKeys: String, CodingKey {
        case code = "sCodigo"
        case documentNumber = "sNumero"
        case documentType = "sTipo"
    }
}

