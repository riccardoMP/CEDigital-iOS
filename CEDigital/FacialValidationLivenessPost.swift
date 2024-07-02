//
//  FacialValidationLivenessPost.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public struct FacialValidationLivenessPost: Codable {
    
    let isToken: String
    let isXUserAgent: String
    let isAuditTrailImage: String
    let isFaceScan: String
    let isLowQualityAuditTrailImage: String
    
}

