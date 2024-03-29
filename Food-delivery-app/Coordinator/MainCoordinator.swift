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
    private let addAppointmentComponent: AddAppointmentComponent
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.editAppointmentComponent = componentFactory.getEditAppointmentComponent()
        self.detailsAppointmentComponent = componentFactory.getDetailsAppointmentComponent()
        self.addAppointmentComponent = componentFactory.getAddAppointmentComponent()
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
		detailsAppointmentComponent.detailsAppointmentViewModel.mainCoordinator = self
		detailsAppointmentComponent.detailsAppointmentViewModel.setAppointment(appointment: model)

		navigationController.pushViewController(detailsAppointmentComponent.detailsAppointmentViewController, animated: true)
	}

	func goToAddAppointmentScreen() {
		addAppointmentComponent.addAppointmentViewModel.coordinator = self

		navigationController.pushViewController(addAppointmentComponent.addAppointmentViewController, animated: true)
	}

    func goToEditAppointmentScreen(appointmentModel: AppointmentModel) {
		let editAppointmentComponent = componentFactory.getEditAppointmentComponent()
		editAppointmentComponent.editAppointmentViewModel.mainCoordinator = self
        editAppointmentComponent.editAppointmentViewModel.setAppointmentModel(appointmentModel: appointmentModel)
		navigationController.pushViewController(editAppointmentComponent.editAppointmentViewController, animated: true)
	}

	func goBack() {
		navigationController.popViewController(animated: true)
	}

    func goToServiceSelectionScreen(selectedServiceIds: [UUID], selectedServiceShortModels: [ServiceShortModel], from opener: ServiceSelectionOpener) {
		let serviceSelectionComponent = componentFactory.getServiceSelectionComponent()
		serviceSelectionComponent.serviceSelectionViewModel.mainCoordinator = self
		serviceSelectionComponent.serviceSelectionViewModel.selectedServiceIds = selectedServiceIds
        serviceSelectionComponent.serviceSelectionViewModel.selectedServiceShortModels = selectedServiceShortModels
        serviceSelectionComponent.serviceSelectionViewModel.opener = opener

		navigationController.present(serviceSelectionComponent.serviceSelectionViewController, animated: true)
	}
    
    func setSelectedServices(opener: ServiceSelectionOpener, _ serviceIdList: [UUID], _ selectedServiceShortModels: [ServiceShortModel]) {
        switch opener {
        case .addAppointmentScreen:
            addAppointmentComponent.addAppointmentViewModel.selectedServiceIds = serviceIdList
        case .editAppointmentScreen:
            editAppointmentComponent.editAppointmentViewModel.selectedServiceIds = serviceIdList
            editAppointmentComponent.editAppointmentViewModel.selectedServiceShortModels = selectedServiceShortModels
        default:
            return
        }
    }
    
    func goBackToDetailsAppointmentScreen(appointment: AppointmentModel) {
        detailsAppointmentComponent.detailsAppointmentViewModel.setAppointment(appointment: appointment)
        detailsAppointmentComponent.detailsAppointmentViewController.configureUI(with: appointment)
        navigationController.popViewController(animated: true)
    }
    
}
