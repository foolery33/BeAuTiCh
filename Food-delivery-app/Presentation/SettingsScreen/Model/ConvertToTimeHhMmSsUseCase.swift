//
//  ConvertToDateHhMmSsUseCase.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import Foundation

class ConvertToTimeHhMmSsUseCase {
	func convert(_ time: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm:ss"
		
		return dateFormatter.string(from: time)
	}
}
