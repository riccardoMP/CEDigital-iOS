//
//  UserLoginDisclaimer.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 17/01/22.
//  Copyright © 2022 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

struct UserLoginDisclaimer: Codable {
    
    let msgCaducidadCE: String?
    let msgVencResidencia: String?
    
    
    func getArrayDisclaimer() -> [String] {
        
        var arrayDisclaimer = [String]()
        
        if let message = msgCaducidadCE, !message.isEmpty {
            arrayDisclaimer.append(msgCaducidadCE ?? "")
            
        }
        
        if let message = msgVencResidencia, !message.isEmpty {
            arrayDisclaimer.append(msgVencResidencia ?? "")
            
        }
        
        return arrayDisclaimer
    }
}

