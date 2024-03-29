//
//  ConvertDateToDdMmYyyyHhMmSsUseCase.swift
//  Food-delivery-app
//
//  Created by Елена on 20.06.2023.
//

import Foundation

class ConvertDateToDdMmYyyyHhMmSsUseCase {
	func convert(_ date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
		return dateFormatter.string(from: date)
	}

	func convertToString(_ date: String) -> String {

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

		if let date = dateFormatter.date(from: date) {
			dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
			return dateFormatter.string(from: date)
		}

		return date
	}
}
