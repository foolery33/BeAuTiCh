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
        goToMainScreen()
//		goToDetailsAppointmentScreen(model: AppointmentModel(id: UUID(), clientName: "Burava", services: [ServiceShortModel(id: UUID(), name: "Bubu"), ServiceShortModel(id: UUID(), name: "Babababababababa"), ServiceShortModel(id: UUID(), name: "Asdasdasd")], price: 340, clientPhone: "89521844366", startDateTime: "23.02.2023 15:00", endDateTime: "23.02.2023 20:00", status: .completed))
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

	func goToEditAppointmentScreen() {
		let editAppointmentComponent = componentFactory.getEditAppointmentComponent()
		editAppointmentComponent.editAppointmentViewModel.coordinator = self

		navigationController.pushViewController(editAppointmentComponent.editAppointmentViewController, animated: true)
	}

	func goBack() {
		navigationController.popViewController(animated: true)
	}

	func goToServiceSelectionScreen(selectedServiceIds: [UUID]) {
		let serviceSelectionComponent = componentFactory.getServiceSelectionComponent()
		serviceSelectionComponent.serviceSelectionViewModel.mainCoordinator = self
		serviceSelectionComponent.serviceSelectionViewModel.selectedServiceIds = selectedServiceIds

		navigationController.present(serviceSelectionComponent.serviceSelectionViewController, animated: true)
	}
}
