//
//  DetailsAppointmentCoordinator.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import UIKit

class DetailsAppointmentCoordinator: CoordinatorProtocol {
	var parentCoordinator: CoordinatorProtocol?
	var children: [CoordinatorProtocol] = []
	var navigationController: UINavigationController

	private let componentFactory = ComponentFactory()

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		//goToDetailsAppointmentScreen()
	}

	func goToAuthScreen() {
		var appc = parentCoordinator as? AppCoordinator

		// TODO: очистить необходимые данные

		appc?.goToAuth()
		appc?.childDidFinish(self)
	}

//	private func goToDetailsAppointmentScreen() {
//		let detailsAppointmentComponent = componentFactory.getDetailsAppointment()
//		detailsAppointmentComponent.detailsAppointmentViewModel.coordinator = self
//
//		navigationController.pushViewController(detailsAppointmentComponent.detailsAppointmentViewController, animated: true)
//	}
}
