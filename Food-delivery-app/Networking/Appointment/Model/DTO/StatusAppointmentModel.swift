//
//  StatusAppointmentModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

enum StatusAppointmentModel: String, Decodable {
    case new = "New"
    case completed = "Completed"
    case cancelled = "Cancelled"
}
