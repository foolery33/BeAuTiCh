//
//  RegisterViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 03.06.2023.
//

class RegisterViewModel {
    
    weak var coordinator: AuthCoordinator?
    
    private let authRepository: AuthRepository
    private let getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase
    private let saveTokensUseCase: SaveTokensUseCase
    private let makeFullNameUseCase: MakeFullNameUseCase
    
    var firstName: String = ""
    var lastName: String = ""
    var patronymic: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var error: String = ""
    
    init(
        authRepository: AuthRepository,
        getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase,
        saveTokensUseCase: SaveTokensUseCase,
        makeFullNameUseCase: MakeFullNameUseCase
    ) {
        self.authRepository = authRepository
        self.getRegisterValidationErrorUseCase = getRegisterValidationErrorUseCase
        self.saveTokensUseCase = saveTokensUseCase
        self.makeFullNameUseCase = makeFullNameUseCase
    }
    
    func register() async -> Bool {
        if let error = getRegisterValidationErrorUseCase.getValidationError(
            lastName: lastName,
            firstName: firstName,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            confirmPassword: confirmPassword
        ) {
            self.error = error
            return false
        }
        do {
            let tokenPairModel = try await authRepository.register(
                credentials: RegisterCredentialsModel(
                    email: email,
                    fullName: makeFullNameUseCase.makeFullName(
                        firstName: firstName,
                        lastName: lastName,
                        patronymic: patronymic
                    ),
                    password: password,
                    phoneNumber: phoneNumber
                )
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
    
    func goBackToLoginScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    
}
