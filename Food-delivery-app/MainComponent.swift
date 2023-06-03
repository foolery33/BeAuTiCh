//
//  MainComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 31.05.2023.
//

import UIKit
import NeedleFoundation

final class MainComponent: BootstrapComponent {
    
    // MARK: - Components
    
    var loginComponent: LoginComponent {
        shared {
            LoginComponent(parent: self)
        }
    }
    
    var registerComponent: RegisterComponent {
        shared {
            RegisterComponent(parent: self)
        }
    }
}
