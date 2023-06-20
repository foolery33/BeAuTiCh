//
//  PasswordEqualityValidationUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class PasswordsEqualityValidationUseCase {
    func areEqualPasswords(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
}
