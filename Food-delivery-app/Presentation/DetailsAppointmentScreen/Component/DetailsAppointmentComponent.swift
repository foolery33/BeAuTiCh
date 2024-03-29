//
//  DetailsAppointmentComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import NeedleFoundation

protocol DetailsAppointmentComponentDependency: Dependency {
    var appointmentRepository: AppointmentRepository { get }
	var convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase { get }
}

class DetailsAppointmentComponent: Component<DetailsAppointmentComponentDependency> {
	var detailsAppointmentViewModel: DetailsAppointmentViewModel {
		shared {
			DetailsAppointmentViewModel(
                appointmentRepository: dependency.appointmentRepository,
                appointment: nil,
                convertStringToDateDdMmYyyyHhMmSsUseCase: dependency.convertStringToDateDdMmYyyyHhMmSsUseCase
            )
		}
	}

	var detailsAppointmentViewController: DetailsAppointmentViewController {
		return DetailsAppointmentViewController(viewModel: detailsAppointmentViewModel)
	}
}
