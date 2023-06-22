//
//  ValidationError.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import Foundation

enum SettingsValidationError: LocalizedError, Identifiable {
	case emptyFieldNameService
	case emptyFieldPrice
	case emptyFieldDuration
	case notValidFieldPrice

	var id: String {
		self.errorDescription
	}

	var errorDescription: String {
		switch self {
		case .emptyFieldNameService:
			return R.string.errors.empty_service_name()
		case .emptyFieldPrice:
			return R.string.errors.empty_service_price()
		case .emptyFieldDuration:
			return R.string.errors.empty_service_duration()
		case .notValidFieldPrice:
			return R.string.errors.not_valid_price()
		}
	}
}
