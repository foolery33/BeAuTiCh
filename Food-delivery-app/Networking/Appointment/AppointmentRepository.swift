//
//  AppointmentRepository.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

protocol AppointmentRepository {
    func getTimezoneAppointments(startDate: String, endDate: String) async throws -> [AppointmentModel]
    func getFilteredAppointments(parameters: FilteredAppointmentsParametersModel) async throws -> [AppointmentModel]
}
