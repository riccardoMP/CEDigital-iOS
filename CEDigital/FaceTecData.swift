//
//  FaceTecData.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 21/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public struct FaceTecData: Codable {
    let success: Bool
    let wasProcessed: Bool
    let scanResultBlob: String
}


