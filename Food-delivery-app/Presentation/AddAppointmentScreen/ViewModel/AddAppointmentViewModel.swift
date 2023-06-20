//
//  AddAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import Foundation

class AddAppointmentViewModel {
	weak var coordinator: MainCoordinator?

	private let componentFactory = ComponentFactory()

	private let convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase

	var selectedServiceIds: [UUID] = []

	init(convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase) {
		self.convertDateToDdMmYyyyHhMmSsUseCase = convertDateToDdMmYyyyHhMmSsUseCase
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

	func saveNewAppointment() {
		//TODO: реализовать
	}
}
