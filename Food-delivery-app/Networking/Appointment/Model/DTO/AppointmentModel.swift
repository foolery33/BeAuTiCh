//
//  AppointmentModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

struct AppointmentModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
		case clientPhone = "clientPhone"
        case clientName = "clientName"
        case services = "services"
        case price = "price"
        case startDateTime = "startDateTime"
        case endDateTime = "endDateTime"
        case status = "status"
    }
    
	init(id: UUID, clientName: String, services: [ServiceShortModel], price: Double, clientPhone: String?, startDateTime: String, endDateTime: String, status: StatusAppointmentModel) {
        self.id = id
        self.clientName = clientName
        self.services = services
		self.clientPhone = clientPhone
        self.price = price
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.status = status
    }
    
    var id: UUID
    var clientName: String
    var services: [ServiceShortModel]
	var clientPhone: String?
    var price: Double
    var startDateTime: String
    var endDateTime: String
    var status: StatusAppointmentModel
    
}
