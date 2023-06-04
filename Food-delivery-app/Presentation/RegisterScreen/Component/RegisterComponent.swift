//
//  RegisterScreenComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 03.06.2023.
//

import NeedleFoundation
import UIKit

protocol RegisterComponentDependencyProtocol: Dependency {
    
}

final class RegisterComponent: Component<RegisterComponentDependencyProtocol> {
    var registerViewModel: RegisterViewModel {
        shared {
            RegisterViewModel()
        }
    }
    
    var registerViewController: UIViewController {
        return RegisterViewController(viewModel: registerViewModel)
    }
}
