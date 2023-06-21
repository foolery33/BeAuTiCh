//
//  DetailsAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import Foundation

class DetailsAppointmentViewModel {
    
    private let appointmentRepository: AppointmentRepository
    
	weak var coordinator: MainCoordinator?
    
	var appointment = Observable<AppointmentModel>()
    var error: String = ""

    init(appointmentRepository: AppointmentRepository, appointment: AppointmentModel?) {
        self.appointmentRepository = appointmentRepository
		if let appointment = appointment {
			self.appointment.updateModel(with: appointment)
		}
	}

	func setAppointment(appointment: AppointmentModel) {
		self.appointment.updateModel(with: appointment)
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
    
}
