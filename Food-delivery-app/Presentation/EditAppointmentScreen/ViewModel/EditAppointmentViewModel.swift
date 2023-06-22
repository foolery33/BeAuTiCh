//
//  EditAppointmentViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import Foundation

class EditAppointmentViewModel {
    
	weak var mainCoordinator: MainCoordinator?
    weak var searchCoordinator: SearchCoordinator?

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
        self.selectedServiceShortModels = appointmentModel.services
    }

	func convertDateToDdMmYyyy(_ date: Date) -> String {
		return convertDateToDdMmYyyyHhMmSsUseCase.convert(date)
	}

	func goBackToDetailsAppointmentScreen() {
        mainCoordinator?.goBackToDetailsAppointmentScreen(appointment: appointment.data
                                                      ?? AppointmentModel(id: UUID(), clientName: String(), services: [], price: Double(), clientPhone: nil, startDateTime: String(), endDateTime: String(), status: .completed))
        searchCoordinator?.goBackToDetailsAppointmentScreen(appointment: appointment.data
                                                            ?? AppointmentModel(id: UUID(), clientName: String(), services: [], price: Double(), clientPhone: nil, startDateTime: String(), endDateTime: String(), status: .completed))
	}

	func goToServiceSelectionScreen() {
        mainCoordinator?.goToServiceSelectionScreen(selectedServiceIds: selectedServiceIds, selectedServiceShortModels: selectedServiceShortModels, from: .editAppointmentScreen)
        searchCoordinator?.showServiceSelectionScreenSheet(selectedServiceIds: selectedServiceIds, from: .searchScreen)
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
                startDateTime: convertToDate(appointmentDate ?? ""),
                servicesId: selectedServiceIds
            )
            print(newInfo)
            try await appointmentRepository.changeAppointmentInformation(appointmentId: appointment.data?.id ?? UUID(), newInfo: newInfo)
            appointment.data?.clientName = newInfo.clientName
            appointment.data?.clientPhone = newInfo.clientPhone
			appointment.data?.startDateTime = self.convertDateToDdMmYyyyHhMmSsUseCase.convertToString(newInfo.startDateTime ?? "")
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
