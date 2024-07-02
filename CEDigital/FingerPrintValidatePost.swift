//
//  FingerPrintValidatePost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public struct FingerPrintValidatePost: Codable {
    
    let biometriaHuellas: [BiometricPost]
    let fotoHuellas: String
    let persona: PersonValidatePost
    
    
}
