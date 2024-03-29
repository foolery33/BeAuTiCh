//
//  AddAppointmentComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import NeedleFoundation

protocol AddAppointmentComponentDependency: Dependency {
	var convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase { get }
    var appointmentRepository: AppointmentRepository { get }
}

class AddAppointmentComponent: Component<AddAppointmentComponentDependency> {
	var addAppointmentViewModel: AddAppointmentViewModel {
		shared {
            AddAppointmentViewModel(
                convertDateToDdMmYyyyHhMmSsUseCase: dependency.convertDateToDdMmYyyyHhMmSsUseCase,
                appointmentRepository: dependency.appointmentRepository
            )
		}
	}

	var addAppointmentViewController: AddAppointmentViewController {
		return AddAppointmentViewController(viewModel: addAppointmentViewModel)
	}
}
