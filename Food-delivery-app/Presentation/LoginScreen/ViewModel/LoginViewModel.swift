//
//  LoginViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import Foundation

final class LoginViewModel {
    
    private let authRepository: AuthRepository
    private let getLoginValidationErrorUseCase: GetLoginValidationErrorUseCase
    private let saveTokensUseCase: SaveTokensUseCase
    
    weak var coordinator: AuthCoordinator?
    
    var email: String = ""
    var password: String = ""
    
    var error: String = ""
    
    init(
        authRepository: AuthRepository,
        getLoginValidationErrorUseCase: GetLoginValidationErrorUseCase,
        saveTokensUseCase: SaveTokensUseCase
    ) {
        self.authRepository = authRepository
        self.getLoginValidationErrorUseCase = getLoginValidationErrorUseCase
        self.saveTokensUseCase = saveTokensUseCase
    }
    
    func login() async -> Bool {
        if let error = getLoginValidationErrorUseCase.getValidationError(
            email: email,
            password: password
        ) {
            self.error = error
            return false
        }
        do {
            let tokenPairModel = try await authRepository.login(
                credentials: LoginCredentialsModel(email: email, password: password)
            )
            saveTokensUseCase.saveTokens(tokenPairModel: tokenPairModel)
            return true
        } catch(let authError) {
            if let appError = authError as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = authError.localizedDescription
            }
            return false
        }
    }
    
    func goToMainScreen() {
        coordinator?.goToMainScreen()
    }
    
    func goToRegisterScreen() {
        coordinator?.goToRegisterScreen()
    }
    
}
