//
//  ViewControllerProtocol.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation

protocol ViewControllerProtocol {
    func initializeUI()
    func setup()
    func updateUI<T>(object : T)
    
}

