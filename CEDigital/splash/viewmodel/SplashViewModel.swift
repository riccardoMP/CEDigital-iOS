//
//  SplashViewModel.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

//https://itnext.io/handling-multiple-requests-using-combine-in-swift-8e19e5c4fa52
//https://www.kiloloco.com/articles/018-chaining-operations-with-swift-and-flatmap/


import Foundation
import Combine

typealias splashViewModel = ViewModelBaseProtocol & SplashViewModelProtocol

final class SplashViewModel : ObservableObject, splashViewModel {
    
    private var interactor: SplashInteractorProtocol
    
    var loadingState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
    
    
    @Published var deviceValidated: Bool?
    @Published var errorMessage: String = ""
    
    init(interactor : SplashInteractorProtocol = SplashInteractorImpl()) {
        self.interactor = interactor
    }
}

extension SplashViewModel {
    
    func generateUUID() {
        interactor.generateUUID()
    }
    
    func doValidationNetwork() {
        self.interactor.isNetworkAvailable()
            .receive(on: DispatchQueue.main)
            .sink { data in
                
                switch data {
                case .failure(let error):
                    self.errorMessage = error.desc
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.validateDevice()
            }
            .store(in: &subscriber)
    }
    
    private func validateDevice() {
        _Concurrency.Task {
            self.loadingState.send(.loadStart)
            
            let publisher = try await self.interactor.validateDevice()
            
            publisher.receive(on: DispatchQueue.main)
                .sink { data in
                    switch data {
                    case .failure(_):
                        self.loadingState.send(.dismissAlert)
                        self.deviceValidated = false
                    case .finished:
                        break
                    }
                    
                } receiveValue: { [weak self] data in
                    self?.deviceValidated = data
                }
                .store(in: &subscriber)
        }
    }
}

