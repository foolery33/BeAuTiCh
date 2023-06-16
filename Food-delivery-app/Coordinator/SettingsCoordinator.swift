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
    
    func goToSettingsScreen() {
        let settingsComponent = componentFactory.getSettingsComponent()
        settingsComponent.settingsViewModel.coordinator = self
        
        navigationController.pushViewController(settingsComponent.settingsViewController, animated: true)
    }
    
    func goToInformationSubcribeScreen(delegate: SheetViewControllerDelegate) {
        let informationSubscribeComponent = componentFactory.getInformationSubscribeComponent()
        informationSubscribeComponent.settingsViewModel.coordinator = self
        informationSubscribeComponent.informationSubscribeController.delegate = delegate
        
        navigationController.present(informationSubscribeComponent.informationSubscribeController, animated: true)
    }
    
    func goToServicesScreen(delegate: SheetViewControllerDelegate) {
        let yourServicesComponent = componentFactory.getYourServicesComponent()
        yourServicesComponent.settingViewModel.coordinator = self
        yourServicesComponent.yourServicesViewController.delegate = delegate
        
        navigationController.present(yourServicesComponent.yourServicesViewController, animated: true)
    }
}
