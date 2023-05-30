//
//  AppCoordinator.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToAuth()
    }
    
    func goToAuth() {
        let authCoordinator = CoordinatorFactory().createAuthCoordinator(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
}
