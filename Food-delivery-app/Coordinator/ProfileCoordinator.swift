//
//  ProfileCoordinator.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
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

	func goToAuthScreen() {
		var appc = parentCoordinator as? AppCoordinator

		// TODO: очистить необходимые данные
        TokenManagerRepositoryImplementation().clearData()

		appc?.goToAuth()
		appc?.childDidFinish(self)
	}

	private func goToProfileScreen() {
		let profileComponent = componentFactory.getProfileComponent()
		profileComponent.profileViewModel.coordinator = self

		navigationController.pushViewController(profileComponent.profileViewController, animated: true)
	}
}
