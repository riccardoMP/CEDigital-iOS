//
//  AuthDocumentViewModel.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 31/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

//https://itnext.io/handling-multiple-requests-using-combine-in-swift-8e19e5c4fa52
//https://www.kiloloco.com/articles/018-chaining-operations-with-swift-and-flatmap/


import Foundation
import Combine

typealias authDocumentViewModel = ViewModelBaseProtocol & AuthDocumentViewModelProtocol

final class AuthDocumentViewModel : ObservableObject, authDocumentViewModel {
    private var interactor: AuthDocumentInteractorProtocol
    
    var loadingState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
    
    
    @Published var userRegisterPost: UserRegisterPost?
    @Published var errorTextField: String = ""
    @Published var errorMessage: String = ""
    
    init(interactor : AuthDocumentInteractorProtocol = AuthDocumentInteractorImpl()) {
        self.interactor = interactor
    }
}

extension AuthDocumentViewModel {
    
    func processPageData(documentNumber: String) {
        self.interactor.isDataValid(documentNumber: documentNumber)
            .receive(on: DispatchQueue.main)
            .sink { data in
                
                switch data {
                case .failure(let error):
                    self.errorTextField = error.desc
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.registerDeviceInformation(documentNumber: documentNumber)
            }
            .store(in: &subscriber)
    }
    
    
    
    private func registerDeviceInformation(documentNumber: String) {
        self.loadingState.send(.loadStart)
        self.interactor.postDeviceInformation(documentNumber: documentNumber)
            .receive(on: DispatchQueue.main)
            .flatMap{ [self]response -> AnyPublisher<UserValidationPost, APIError> in
                return interactor.processDeviceInformation(documentNumber: documentNumber, bearerToken: response?.data?.authorization)
            }
            .sink { data in
                switch data {
                case .failure(let error):
                    self.loadingState.send(.dismissAlert)
                    self.errorMessage = error.desc
                case .finished:
                    break
                }
                
            } receiveValue: { [weak self] data in
                self?.validateUser(post: data)
            }
            .store(in: &subscriber)
    }
    
    private func validateUser(post: UserValidationPost) {
        self.interactor.postValidateUser(post: post)
            .receive(on: DispatchQueue.main)
            .flatMap{ [self]response -> AnyPublisher<UserRegisterPost, APIError> in
                return interactor.processUserValidated(user: response?.data)
            }
            .sink { data in
                switch data {
                case .failure(let error):
                    self.errorMessage = error.desc
                case .finished:
                    break
                }
                
                self.loadingState.send(.dismissAlert)
                
            } receiveValue: { [weak self] data in
                self?.userRegisterPost = data
            }
            .store(in: &subscriber)
    }
}

