//
//  SearchViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

final class SearchViewModel {
    
    weak var coordinator: SearchCoordinator?
    private let appointmentRepository: AppointmentRepository
    private let convertISOToReadableDateAndTimeUseCase: ConvertISOToReadableDateAndTimeUseCase
    private let getFilteredAppointmentListUseCase: GetFilteredAppointmentListUseCase
    
    init(appointmentRepository: AppointmentRepository, convertISOToReadableDateAndTimeUseCase: ConvertISOToReadableDateAndTimeUseCase, getFilteredAppointmentListUseCase: GetFilteredAppointmentListUseCase) {
        self.appointmentRepository = appointmentRepository
        self.convertISOToReadableDateAndTimeUseCase = convertISOToReadableDateAndTimeUseCase
        self.getFilteredAppointmentListUseCase = getFilteredAppointmentListUseCase
    }
    
    var clientName: String = ""
    var appointmentList: [AppointmentModel] = []
    var error: String = ""
    
    var startPrice: Int?
    var endPrice: Int?
    var startDate: String?
    var endDate: String?
    var page: Int?
    var servicesId: [String] = []
    
    func getAppointmentList() async -> Bool {
        let parameters = FilteredAppointmentsParametersModel(
            startPrice: startPrice,
            endPrice: endPrice,
            startDate: startDate,
            endDate: endDate,
            servicesId: servicesId
        )
        do {
            self.appointmentList = try await appointmentRepository.getFilteredAppointments(parameters: parameters)
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
    
    func convertISOToReadableDateAndTime(_ dateTime: String) -> String {
        convertISOToReadableDateAndTimeUseCase.formatDateString(dateTime) ?? ""
    }
    
    func getFilteredAppointmentList(from appointmentList: [AppointmentModel], with filterString: String) -> [AppointmentModel] {
        getFilteredAppointmentListUseCase.getFilteredAppointmentList(from: appointmentList, with: filterString)
    }
    
    func goToFilterScreen() {
        coordinator?.goToFilterScreen()
    }
    
}
