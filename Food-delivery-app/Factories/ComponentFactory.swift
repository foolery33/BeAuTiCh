//
//  ComponentFactory.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 31.05.2023.
//

import Foundation

final class ComponentFactory {
    
    private var mainComponent = MainComponent()
    
    func getLoginComponent() -> LoginComponent {
        return mainComponent.loginComponent
    }
    
    func getRegisterComponent() -> RegisterComponent {
        return mainComponent.registerComponent
    }
}
