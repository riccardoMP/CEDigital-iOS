//
//  BaseResponse.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

struct BaseDTO<T: Codable>: Codable {
    let codigo: String
    let mensaje: String
    let data: T?
}
