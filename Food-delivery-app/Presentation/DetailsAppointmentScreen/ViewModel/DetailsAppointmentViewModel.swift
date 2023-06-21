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
    
	weak var mainCoordinator: MainCoordinator?
	weak var searchCoordinator: SearchCoordinator?
    
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

	func deleteAppointment() async -> Bool {
		do {
			if let appointmentId = self.appointment.data?.id {
				_ = try await appointmentRepository.deleteAppointment(appointmentId: appointmentId)
				return true
			}

			return false

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
    
    func goBackScreen() {
		if let mainCoordinator = mainCoordinator {
			mainCoordinator.navigationController.popViewController(animated: true)

		} else if let searchCoordinator = searchCoordinator {
			searchCoordinator.navigationController.popViewController(animated: true)
		}
    }

	func conventStringDateToDdMmYyyy(_ date: String) -> String {
		return convertStringToDateDdMmYyyyHhMmSsUseCase.convert(date)
	}
    
    func goToEditAppointmentScreen() {
        coordinator?.goToEditAppointmentScreen(appointmentModel: appointment.data ?? AppointmentModel(id: UUID(), clientName: String(), services: [], price: Double(), clientPhone: nil, startDateTime: String(), endDateTime: String(), status: .completed))
    }
    
}
