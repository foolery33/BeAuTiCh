//
//  MainCoordinator.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import UIKit

final class MainCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController

    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
		goToAddAppointmentScreen()
    }
    
    private func goToMainScreen() {
        let mainScreenComponent = componentFactory.getMainScreenComponent()
        mainScreenComponent.mainViewModel.coordinator = self
        navigationController.pushViewController(mainScreenComponent.mainViewController, animated: true)
    }

	func goToDetailsAppointmentScreen(model: AppointmentModel) {
		let detailsAppointmentComponent = componentFactory.getDetailsAppointment()
		detailsAppointmentComponent.detailsAppointmentViewModel.coordinator = self
		detailsAppointmentComponent.detailsAppointmentViewModel.setAppointment(appointment: model)

		navigationController.pushViewController(detailsAppointmentComponent.detailsAppointmentViewController, animated: true)
	}

	func goToAddAppointmentScreen() {
		let addAppointmentComponent = componentFactory.getAddAppointmentComponent()
		addAppointmentComponent.addAppointmentViewModel.coordinator = self

		navigationController.pushViewController(addAppointmentComponent.addAppointmentViewController, animated: true)
	}
}
