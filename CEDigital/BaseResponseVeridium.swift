//
//  BaseResponseVeridium.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

struct BaseResponseVeridium<T: Codable>: Codable {
    let code: String
    let message: String
    let data: T?
}

