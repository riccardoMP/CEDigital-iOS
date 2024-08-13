//
//  MessageHelper.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

struct MessageHelper {
    
    /// General Message Handler
    struct serverError {
        static let general : String = "general_error_400".localized
        static let noInternet : String = "generic_description_no_internet".localized
        static let timeOut : String = "general_error_timeout".localized
        static let notFound : String = "general_error_not_found".localized
        static let serverError : String = "general_error".localized
        static let attemptsLimit : String = "general_error_attempts_limit".localized
    }
}
