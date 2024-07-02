//
//  SessionProtocol.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

protocol SessionProtocol {
    func onSessionWillExpire()
    func onSessionLogout()
    
}
