//
//  DetailsAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

class DetailsAppointmentViewModel {
	weak var coordinator: MainCoordinator?

	var appointment = Observable<AppointmentModel>()

	private let convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase

	init(convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase) {
		self.convertStringToDateDdMmYyyyHhMmSsUseCase = convertStringToDateDdMmYyyyHhMmSsUseCase
	}

	func setAppointment(appointment: AppointmentModel) {
		let startDateTime = conventStringDateToDdMmYyyy(appointment.startDateTime)
		let endDateTime = conventStringDateToDdMmYyyy(appointment.endDateTime)

		let correctAppointment = AppointmentModel(id: appointment.id, clientName: appointment.clientName, services: appointment.services, price: appointment.price, clientPhone: appointment.clientPhone, startDateTime: startDateTime, endDateTime: endDateTime, status: appointment.status)
		self.appointment.updateModel(with: correctAppointment)
	}

	func conventStringDateToDdMmYyyy(_ date: String) -> String {
		return convertStringToDateDdMmYyyyHhMmSsUseCase.convert(date)
	}
}
