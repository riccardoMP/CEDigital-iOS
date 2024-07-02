//
//  FacialValidationMigrationResponse.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 22/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public struct FacialValidationMigrationResponse: Codable {
    let success: Bool
    let wasProcessed: Bool
    let scanResultBlob: String?
}
