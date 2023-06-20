//
//  DetailsAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

class DetailsAppointmentViewModel {
	weak var coordinator: MainCoordinator?

	var appointment = Observable<AppointmentModel>()

	init(appointment: AppointmentModel?) {
		if let appointment = appointment {
			self.appointment.updateModel(with: appointment)
		}
	}

	func setAppointment(appointment: AppointmentModel) {
		self.appointment.updateModel(with: appointment)
	}
}
