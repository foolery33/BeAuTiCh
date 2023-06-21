//
//  ConvertStringToDateDdMmYyyyHhMmSsUseCase.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import Foundation

final class ConvertStringToDateDdMmYyyyHhMmSsUseCase {
	func convert(_ date: String) -> String {

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00")

		if let date = dateFormatter.date(from: date) {
			dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
			return dateFormatter.string(from: date)
		}

		return date
	}

}
