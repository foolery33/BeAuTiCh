//
//  GetFilteredAppointmentListUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import Foundation

final class GetFilteredAppointmentListUseCase {
    
    func getFilteredAppointmentList(from appointmentList: [AppointmentModel], with filterString: String) -> [AppointmentModel] {
        return appointmentList.filter({ $0.clientName.contains(filterString) })
    }
    
}
