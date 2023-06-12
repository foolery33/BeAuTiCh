//
//  ProfileCoordinator.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit

class ProfileCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToProfileScreen()
    }
    
    private func goToProfileScreen() {
        let profileComponent = componentFactory.getProfileScreenComponent()
        profileComponent.profileViewModel.coordinator = self
        
        navigationController.pushViewController(profileComponent.profileViewController, animated: true)
    }
}
