//
//  ProcesingDelegate.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 20/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import FaceTecSDK

// Class that allows all Processors to have a common type and a common way to query the success
// This is done for demonstration purposes and you do not need to define this in your classes.
protocol Processor: AnyObject {
    func isSuccess() -> Bool
}
