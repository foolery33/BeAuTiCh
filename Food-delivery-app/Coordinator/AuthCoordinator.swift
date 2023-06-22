//
//  AuthCoordinator.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import UIKit

final class AuthCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if UserDefaults.standard.bool(forKey: "wasLaunched") == false {
            goToStartScreen()
            UserDefaults.standard.set(true, forKey: "wasLaunched")
        }
        else {
            goToLoginScreen()
        }
    }
    
    func goToStartScreen() {
        let startComponent = componentFactory.getStartComponent()
        startComponent.startViewModel.coordinator = self
        
        navigationController.pushViewController(
            startComponent.startViewController, animated: true
        )
    }
    
    func goToLoginScreen() {
        let loginComponent = componentFactory.getLoginComponent()
        loginComponent.loginViewModel.coordinator = self
        
        navigationController.pushViewController(
            loginComponent.loginViewController, animated: false
        )
    }
    
    func goToRegisterScreen() {
        let registerComponent = componentFactory.getRegisterComponent()
        registerComponent.registerViewModel.coordinator = self
        
        navigationController.pushViewController(
            registerComponent.registerViewController, animated: true
        )
    }
    
    func goToMainScreen() {
        if let appCoordinator = parentCoordinator as? AppCoordinator {
            appCoordinator.goToMain()
            parentCoordinator?.childDidFinish(self)
        }
    }
    
}
