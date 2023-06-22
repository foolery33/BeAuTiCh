//
//  AddAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import Foundation

class AddAppointmentViewModel {
	weak var coordinator: MainCoordinator?

	private let convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase
    private let appointmentRepository: AppointmentRepository

	var selectedServiceIds: [UUID] = []
    
    var clientName: String = ""
    var appointmentDate: String?
    var phoneNumber: String?
    
    var error: String = ""

	init(convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase, appointmentRepository: AppointmentRepository) {
		self.convertDateToDdMmYyyyHhMmSsUseCase = convertDateToDdMmYyyyHhMmSsUseCase
        self.appointmentRepository = appointmentRepository
	}

	func convertDateToDdMmYyyy(_ date: Date) -> String {
		return convertDateToDdMmYyyyHhMmSsUseCase.convert(date)
	}

	func goBack() {
		coordinator?.goBack()
	}

	func goToServiceSelectionScreen() {
        coordinator?.goToServiceSelectionScreen(selectedServiceIds: selectedServiceIds, from: .addAppointmentScreen)
	}

    func createAppointment() async -> Bool {
        do {
            if clientName.count == 0 {
                error = R.string.errors.empty_client_name()
                return false
            }
            let newAppointment = AddAppointmentModel(
                clientName: clientName,
                clientPhone: phoneNumber,
                startDateTime: convertToDate(appointmentDate ?? ""),
                idServices: selectedServiceIds
            )
            print(newAppointment)
            _ = try await appointmentRepository.createAppointment(
                newAppointmentModel: newAppointment
            )
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return false
        }
    }
    
    func convertToDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
		dateFormatter.locale = .current
		dateFormatter.timeZone = .current

		if let date = dateFormatter.date(from: dateString) {
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
			return dateFormatter.string(from: date)
		}

        return dateString
    }
    
}
