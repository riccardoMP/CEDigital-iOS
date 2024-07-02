//
//  FacialValidationMigrationPost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 22/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public struct FacialValidationMigrationPost: Codable {
    let isAuditTrailImage: String
    let isFaceScan: String
    let isLowQualityAuditTrailImage: String
    let isToken: String
    let isXUserAgent: String
    let persona: PersonValidatePost
}

