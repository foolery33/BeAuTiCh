//
//  GetLoginValidationErrorUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class GetLoginValidationErrorUseCase {
    
    var emptyValidationUseCase: EmptyValidationUseCase
    var emailValidationUseCase: EmailValidationUseCase
    
    init(emptyValidationUseCase: EmptyValidationUseCase, emailValidationUseCase: EmailValidationUseCase) {
        self.emptyValidationUseCase = emptyValidationUseCase
        self.emailValidationUseCase = emailValidationUseCase
    }
    
    func getValidationError(email: String, password: String) -> String? {
        if emptyValidationUseCase.isEmptyField(email) {
            return R.string.errors.empty_email()
        }
        if emptyValidationUseCase.isEmptyField(password) {
            return R.string.errors.empty_password()
        }
        if emailValidationUseCase.isValidEmail(email) == false {
            return R.string.errors.invalid_email()
        }
        return nil
    }
    
}
