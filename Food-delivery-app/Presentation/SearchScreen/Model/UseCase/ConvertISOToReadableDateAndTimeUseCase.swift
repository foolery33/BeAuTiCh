//
//  ConvertISOToReadableDateAndTimeUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import Foundation

final class ConvertISOToReadableDateAndTimeUseCase {
    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            return dateFormatter.string(from: date)
        }

		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

		if let date = dateFormatter.date(from: dateString) {
			dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
			return dateFormatter.string(from: date)
		}

        return nil
    }
    
}
