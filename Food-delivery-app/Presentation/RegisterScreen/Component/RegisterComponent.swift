//
//  RegisterScreenComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 03.06.2023.
//

import NeedleFoundation
import UIKit

protocol RegisterComponentDependencyProtocol: Dependency {
    var authRepository: AuthRepository { get }
    var getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase { get }
    var saveTokensUseCase: SaveTokensUseCase { get }
    var makeFullNameUseCase: MakeFullNameUseCase { get }
}

final class RegisterComponent: Component<RegisterComponentDependencyProtocol> {
    var registerViewModel: RegisterViewModel {
        shared {
            RegisterViewModel(
                authRepository: dependency.authRepository,
                getRegisterValidationErrorUseCase: dependency.getRegisterValidationErrorUseCase,
                saveTokensUseCase: dependency.saveTokensUseCase,
                makeFullNameUseCase: dependency.makeFullNameUseCase
            )
        }
    }
    
    var registerViewController: UIViewController {
        return RegisterViewController(viewModel: registerViewModel)
    }
}
