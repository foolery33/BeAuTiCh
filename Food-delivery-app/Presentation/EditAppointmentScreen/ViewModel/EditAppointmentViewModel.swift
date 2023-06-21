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
    private let convertDdMmYyyyHhMmSsToISOUseCase: ConvertDdMmYyyyHhMmSsToISOUseCase
    private let appointmentRepository: AppointmentRepository

	var selectedServiceIds: [UUID] = []
    var selectedServiceShortModels: [ServiceShortModel] = []
	var appointment = Observable<AppointmentModel>()
    
    var clientName: String = ""
    var appointmentDate: String?
    var phoneNumber: String?
    
    var error: String = ""

    init(convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase, convertDdMmYyyyHhMmSsToISOUseCase: ConvertDdMmYyyyHhMmSsToISOUseCase, appointmentRepository: AppointmentRepository) {
		self.convertDateToDdMmYyyyHhMmSsUseCase = convertDateToDdMmYyyyHhMmSsUseCase
        self.convertDdMmYyyyHhMmSsToISOUseCase = convertDdMmYyyyHhMmSsToISOUseCase
        self.appointmentRepository = appointmentRepository
	}
    
    func setAppointmentModel(appointmentModel: AppointmentModel) {
        self.appointment.updateModel(with: appointmentModel)
        self.clientName = appointment.data?.clientName ?? ""
        self.appointmentDate = appointment.data?.startDateTime
        self.phoneNumber = appointment.data?.clientPhone
        self.selectedServiceIds = appointmentModel.services.map { $0.id }
    }

	func convertDateToDdMmYyyy(_ date: Date) -> String {
		return convertDateToDdMmYyyyHhMmSsUseCase.convert(date)
	}

	func goBackToDetailsAppointmentScreen() {
        coordinator?.goBackToDetailsAppointmentScreen(appointment: appointment.data
                                                      ?? AppointmentModel(id: UUID(), clientName: String(), services: [], price: Double(), clientPhone: nil, startDateTime: String(), endDateTime: String(), status: .completed))
	}

	func goToServiceSelectionScreen() {
        coordinator?.goToServiceSelectionScreen(selectedServiceIds: selectedServiceIds, from: .editAppointmentScreen)
	}

    func changeAppointmentInfo() async -> Bool {
        do {
            if clientName.count == 0 {
                error = R.string.errors.empty_client_name()
                return false
            }
            let newInfo = EditAppointmentModel(
                clientName: clientName,
                clientPhone: phoneNumber,
                startDateTime: "\(convertToDate(appointmentDate ?? "") ?? Date())",
                servicesId: selectedServiceIds
            )
            print(newInfo)
            _ = try await appointmentRepository.changeAppointmentInformation(appointmentId: appointment.data?.id ?? UUID(), newInfo: newInfo)
            appointment.data?.clientName = newInfo.clientName
            appointment.data?.clientPhone = newInfo.clientPhone
            appointment.data?.startDateTime = newInfo.startDateTime ?? ""
            appointment.data?.services = selectedServiceShortModels
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
    
    func convertToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: dateString)
    }
}
