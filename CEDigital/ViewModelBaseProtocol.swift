//
//  ViewModelBaseProtocol.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Combine

// MARK: BaseViewModel

enum ViewModelStatus : Equatable {
    case loadStart
    case validating
    case dismissAlert
}

protocol ViewModelBaseProtocol {
    var loadingState : CurrentValueSubject<ViewModelStatus, Never> { get set }
    var subscriber : Set<AnyCancellable> { get }
}
