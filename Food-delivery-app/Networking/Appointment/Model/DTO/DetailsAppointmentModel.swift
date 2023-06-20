//
//  DetailsAppointmentModel.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import Foundation

struct DetailsAppointmentModel {
	let id: UUID
	let clientName: String
	let services: [ServiceShortModel]
	let price: String
	let startDateTime: String
	let endDateTime: String
	let status: StatusAppointmentModel
}
