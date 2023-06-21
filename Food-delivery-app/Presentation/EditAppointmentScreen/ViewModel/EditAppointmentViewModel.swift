//
//  EditAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import Foundation

class EditAppointmentViewModel {
	weak var coordinator: MainCoordinator?

	private let convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase

	var selectedServiceIds: [UUID] = []
	var appointment = Observable<AppointmentModel>()

	init(convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase) {
		self.convertDateToDdMmYyyyHhMmSsUseCase = convertDateToDdMmYyyyHhMmSsUseCase

		let appointment = AppointmentModel(id: UUID(), clientName: "Blabla", services: [], price: 0, clientPhone: "1234678911", startDateTime: "2023-06-20T17:44:14.681Z", endDateTime: "2023-07-20T17:44:14.681Z", status: .new)

		self.appointment.updateModel(with: appointment)
	}

	func convertDateToDdMmYyyy(_ date: Date) -> String {
		return convertDateToDdMmYyyyHhMmSsUseCase.convert(date)
	}

	func goBack() {
		coordinator?.goBack()
	}

	func goToServiceSelectionScreen() {
		coordinator?.goToServiceSelectionScreen(selectedServiceIds: selectedServiceIds)
	}

	func saveEditData() {
		//TODO: реализовать
	}
}
