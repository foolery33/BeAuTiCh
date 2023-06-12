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
    
    private let coordinatorFactory = CoordinatorFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if UserDefaults.standard.bool(forKey: "wasLaunched") == false {
            goToAuth()
        }
        else {
            goToMain()
        }
    }
    
    func goToAuth() {
        let authCoordinator = coordinatorFactory.createAuthCoordinator(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
    func goToMain() {
        let mainCoordinator = coordinatorFactory.createMainTabBarCoordinator(navigationController: navigationController)
        mainCoordinator.parentCoordinator = self
        children.append(mainCoordinator)
        mainCoordinator.start()
    }
    
}
