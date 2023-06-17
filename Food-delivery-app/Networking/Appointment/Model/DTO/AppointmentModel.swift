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
        case clientName = "clientName"
        case price = "price"
        case startDateTime = "startDateTime"
        case endDateTime = "endDateTime"
        case status = "status"
    }
    
    init(id: UUID, clientName: String, price: Double, startDateTime: String, endDateTime: String, status: StatusAppointmentModel) {
        self.id = id
        self.clientName = clientName
        self.price = price
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.status = status
    }
    
    var id: UUID
    var clientName: String
    var price: Double
    var startDateTime: String
    var endDateTime: String
    var status: StatusAppointmentModel
    
}
