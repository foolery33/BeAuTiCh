//
//  AuthCoordinator.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import UIKit

class AuthCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginScreen()
    }
    
    func goToLoginScreen() {
        let loginComponent = componentFactory.getLoginComponent()
        loginComponent.loginViewModel.coordinator = self
        navigationController.pushViewController(
            loginComponent.loginViewController, animated: true
        )
    }
    
}
