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
    private let editAppointmentComponent: EditAppointmentComponent
    private let detailsAppointmentComponent: DetailsAppointmentComponent
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.editAppointmentComponent = componentFactory.getEditAppointmentComponent()
        self.detailsAppointmentComponent = componentFactory.getDetailsAppointmentComponent()
    }
    
    func start() {
        goToMainScreen()
    }
    
    private func goToMainScreen() {
        let mainScreenComponent = componentFactory.getMainScreenComponent()
        mainScreenComponent.mainViewModel.coordinator = self
        navigationController.pushViewController(mainScreenComponent.mainViewController, animated: true)
    }

	func goToDetailsAppointmentScreen(model: AppointmentModel) {
		detailsAppointmentComponent.detailsAppointmentViewModel.coordinator = self
		detailsAppointmentComponent.detailsAppointmentViewModel.setAppointment(appointment: model)

		navigationController.pushViewController(detailsAppointmentComponent.detailsAppointmentViewController, animated: true)
	}

	func goToAddAppointmentScreen() {
		let addAppointmentComponent = componentFactory.getAddAppointmentComponent()
		addAppointmentComponent.addAppointmentViewModel.coordinator = self

		navigationController.pushViewController(addAppointmentComponent.addAppointmentViewController, animated: true)
	}

    func goToEditAppointmentScreen(appointmentModel: AppointmentModel) {
		let editAppointmentComponent = componentFactory.getEditAppointmentComponent()
		editAppointmentComponent.editAppointmentViewModel.coordinator = self
        editAppointmentComponent.editAppointmentViewModel.setAppointmentModel(appointmentModel: appointmentModel)
		navigationController.pushViewController(editAppointmentComponent.editAppointmentViewController, animated: true)
	}

	func goBack() {
		navigationController.popViewController(animated: true)
	}

    func goToServiceSelectionScreen(selectedServiceIds: [UUID], from opener: ServiceSelectionOpener) {
		let serviceSelectionComponent = componentFactory.getServiceSelectionComponent()
		serviceSelectionComponent.serviceSelectionViewModel.mainCoordinator = self
		serviceSelectionComponent.serviceSelectionViewModel.selectedServiceIds = selectedServiceIds
        serviceSelectionComponent.serviceSelectionViewModel.opener = opener

		navigationController.present(serviceSelectionComponent.serviceSelectionViewController, animated: true)
	}
    
    func setSelectedServices(_ serviceIdList: [UUID], _ selectedServiceShortModels: [ServiceShortModel]) {
        editAppointmentComponent.editAppointmentViewModel.selectedServiceIds = serviceIdList
        editAppointmentComponent.editAppointmentViewModel.selectedServiceShortModels = selectedServiceShortModels
    }
    
    func goBackToDetailsAppointmentScreen(appointment: AppointmentModel) {
        detailsAppointmentComponent.detailsAppointmentViewModel.setAppointment(appointment: appointment)
        detailsAppointmentComponent.detailsAppointmentViewController.configureUI(with: appointment)
        navigationController.popViewController(animated: true)
    }
    
}
