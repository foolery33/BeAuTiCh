//
//  LoginComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 31.05.2023.
//

import UIKit
import NeedleFoundation

protocol LoginComponentDependency: Dependency {
    var authRepository: AuthRepository { get }
    var getLoginValidationErrorUseCase: GetLoginValidationErrorUseCase { get }
    var saveTokensUseCase: SaveTokensUseCase { get }
}

final class LoginComponent: Component<LoginComponentDependency> {
    
    var loginViewModel: LoginViewModel {
        shared {
            LoginViewModel(
                authRepository: dependency.authRepository,
                getLoginValidationErrorUseCase: dependency.getLoginValidationErrorUseCase,
                saveTokensUseCase: dependency.saveTokensUseCase
            )
        }
    }
    
    var loginViewController: UIViewController {
        return LoginViewController(viewModel: loginViewModel)
    }
    
}
