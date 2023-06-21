//
//  EditAppointmentModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 21.06.2023.
//

import Foundation

struct EditAppointmentModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case clientName = "clientName"
        case clientPhone = "clientPhone"
        case startDateTime = "startDateTime"
        case servicesId = "servicesId"
    }
    
    init(clientName: String, clientPhone: String? = nil, startDateTime: String? = nil, servicesId: [UUID]? = nil) {
        self.clientName = clientName
        self.clientPhone = clientPhone
        self.startDateTime = startDateTime
        self.servicesId = servicesId
    }
    
    var clientName: String
    var clientPhone: String?
    var startDateTime: String?
    var servicesId: [UUID]?
    
}
