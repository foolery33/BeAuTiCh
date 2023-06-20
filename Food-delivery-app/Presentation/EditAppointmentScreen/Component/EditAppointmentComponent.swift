//
//  EditAppointmentComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import NeedleFoundation

protocol EditAppointmentComponentDependency: Dependency {
	var convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase { get }
}

class EditAppointmentComponent: Component<EditAppointmentComponentDependency> {
	var editAppointmentViewModel: EditAppointmentViewModel {
		shared {
			EditAppointmentViewModel(convertDateToDdMmYyyyHhMmSsUseCase: dependency.convertDateToDdMmYyyyHhMmSsUseCase)
		}
	}

	var editAppointmentViewController: EditAppointmentViewController {
		return EditAppointmentViewController(viewModel: editAppointmentViewModel)
	}
}
