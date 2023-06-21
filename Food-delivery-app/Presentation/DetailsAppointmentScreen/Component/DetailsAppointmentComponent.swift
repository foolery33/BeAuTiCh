//
//  DetailsAppointmentComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import NeedleFoundation

protocol DetailsAppointmentComponentDependency: Dependency {
	var convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase { get }
}

class DetailsAppointmentComponent: Component<DetailsAppointmentComponentDependency> {
	var detailsAppointmentViewModel: DetailsAppointmentViewModel {
		shared {
			DetailsAppointmentViewModel(convertStringToDateDdMmYyyyHhMmSsUseCase: dependency.convertStringToDateDdMmYyyyHhMmSsUseCase)
		}
	}

	var detailsAppointmentViewController: DetailsAppointmentViewController {
		return DetailsAppointmentViewController(viewModel: detailsAppointmentViewModel)
	}
}
