//
//  DetailsAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import Foundation

class DetailsAppointmentViewModel {
    
    private let appointmentRepository: AppointmentRepository
    private let convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase
    
	weak var coordinator: MainCoordinator?
    
	var appointment = Observable<AppointmentModel>()
    var error: String = ""

    init(appointmentRepository: AppointmentRepository, appointment: AppointmentModel?, convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase) {
        self.appointmentRepository = appointmentRepository
		if let appointment = appointment {
			self.appointment.updateModel(with: appointment)
	    }
        self.convertStringToDateDdMmYyyyHhMmSsUseCase = convertStringToDateDdMmYyyyHhMmSsUseCase
    }

	func setAppointment(appointment: AppointmentModel) {
		let startDateTime = conventStringDateToDdMmYyyy(appointment.startDateTime)
		let endDateTime = conventStringDateToDdMmYyyy(appointment.endDateTime)

		let correctAppointment = AppointmentModel(id: appointment.id, clientName: appointment.clientName, services: appointment.services, price: appointment.price, clientPhone: appointment.clientPhone, startDateTime: startDateTime, endDateTime: endDateTime, status: appointment.status)
		self.appointment.updateModel(with: correctAppointment)
	}
    
    func changeAppointmentStatus(newStatus: StatusAppointmentModel) async -> Bool {
        do {
            _ = try await appointmentRepository.changeAppointmentStatus(appointmentId: appointment.data?.id ?? UUID(), newStatus: newStatus)
            appointment.data?.status = newStatus
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
    
    func goBackToMainScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    

	func conventStringDateToDdMmYyyy(_ date: String) -> String {
		return convertStringToDateDdMmYyyyHhMmSsUseCase.convert(date)
	}
}
