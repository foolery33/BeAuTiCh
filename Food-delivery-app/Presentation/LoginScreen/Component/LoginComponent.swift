//
//  LoginComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 31.05.2023.
//

import UIKit
import NeedleFoundation

protocol LoginComponentDependency: Dependency {
    
}

final class LoginComponent: Component<LoginComponentDependency> {
    
    var loginViewModel: LoginViewModel {
        shared {
            LoginViewModel()
        }
    }
    
    var loginViewController: UIViewController {
        return LoginViewController(viewModel: loginViewModel)
    }
    
}
