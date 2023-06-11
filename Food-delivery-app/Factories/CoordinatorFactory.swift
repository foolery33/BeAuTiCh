//
//  CoordinatorFactory.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 30.05.2023.
//

import UIKit

final class CoordinatorFactory {
    func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        return AppCoordinator(navigationController: navigationController)
    }
    func createAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        return AuthCoordinator(navigationController: navigationController)
    }
    func createMainTabBarCoordinator(navigationController: UINavigationController) -> MainTabBarCoordinator {
        return MainTabBarCoordinator(navigationController: navigationController)
    }
}
