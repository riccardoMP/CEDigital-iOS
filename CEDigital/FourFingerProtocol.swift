//
//  FourFingerProtocol.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 6/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation


public protocol FourFingerProtocol {
    
    func onFourFingerProcessed(arrayBiometric: [BiometricPost], photoAudit: String)
    func onFourFingerFailure(message :String)
    
}

