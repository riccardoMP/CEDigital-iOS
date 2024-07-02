//
//  FacialValidationProtocol.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 20/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation


public protocol FacialValidationProtocol {
    
    func onFacialValidatedSDK(post: FacialValidationMigrationPost)
    func onFacialValidatedFailure(message :String)
    
}
