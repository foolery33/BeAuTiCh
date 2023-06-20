//
//  GetRegisterValidationErrorUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class GetRegisterValidationErrorUseCase {
    
    var emptyValidationUseCase: EmptyValidationUseCase
    var emailValidationUseCase: EmailValidationUseCase
    var phoneNumberValidationUseCase: PhoneNumberValidationUseCase
    var passwordsEqualityValidationUseCase: PasswordsEqualityValidationUseCase
    var passwordValidationUseCase: PasswordValidationUseCase
    
    init(emptyValidationUseCase: EmptyValidationUseCase, emailValidationUseCase: EmailValidationUseCase,
         phoneNumberValidationUseCase: PhoneNumberValidationUseCase, passwordsEqualityValidationUseCase: PasswordsEqualityValidationUseCase, passwordValidationUseCase: PasswordValidationUseCase) {
        self.emptyValidationUseCase = emptyValidationUseCase
        self.emailValidationUseCase = emailValidationUseCase
        self.phoneNumberValidationUseCase = phoneNumberValidationUseCase
        self.passwordsEqualityValidationUseCase = passwordsEqualityValidationUseCase
        self.passwordValidationUseCase = passwordValidationUseCase
    }
    
    func getValidationError(lastName: String, firstName: String, email: String, phoneNumber: String, password: String, confirmPassword: String) -> String? {
        if emptyValidationUseCase.isEmptyField(lastName) {
            return R.string.errors.empty_last_name()
        }
        if emptyValidationUseCase.isEmptyField(firstName) {
            return R.string.errors.empty_first_name()
        }
        if emptyValidationUseCase.isEmptyField(email) {
            return R.string.errors.empty_email()
        }
        if emptyValidationUseCase.isEmptyField(password) {
            return R.string.errors.empty_password()
        }
        if emptyValidationUseCase.isEmptyField(confirmPassword) {
            return R.string.errors.empty_confirm_password()
        }
        if emailValidationUseCase.isValidEmail(email) == false {
            return R.string.errors.invalid_email()
        }
        if phoneNumberValidationUseCase.isValidPhoneNumber(phoneNumber) == false {
            return R.string.errors.invalid_phone_number()
        }
        if passwordsEqualityValidationUseCase.areEqualPasswords(password, confirmPassword) == false {
            return R.string.errors.different_passwords()
        }
        if passwordValidationUseCase.isValidPassword(password) == false {
            return R.string.errors.invalid_password()
        }
        return nil
    }
}
