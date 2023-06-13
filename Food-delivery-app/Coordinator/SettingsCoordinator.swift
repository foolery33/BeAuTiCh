//
//  SettingsCoordinator.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

class SettingsCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSettingsScreen()
    }
    
    private func goToSettingsScreen() {
        let settingsComponent = componentFactory.getSettingsComponent()
        settingsComponent.settingsViewModel.coordinator = self
        
        navigationController.pushViewController(settingsComponent.settingsViewController, animated: true)
    }
}
