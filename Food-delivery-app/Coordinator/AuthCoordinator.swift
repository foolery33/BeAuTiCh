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
    
    // MARK: - ViewModels
    private let loginViewModel = LoginViewModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginScreen()
    }
    
    func goToLoginScreen() {
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        loginViewModel.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
}
