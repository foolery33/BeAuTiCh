//
//  GetSettingsValidationErrorUseCase.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

final class GetSettingsValidationErrorUseCase {
	var emptyValidationUseCase: EmptyValidationUseCase
	var priceValidationUseCase: PriceValidationUseCase

	init(emptyValidationUseCase: EmptyValidationUseCase, priceValidationUseCase: PriceValidationUseCase) {
		self.emptyValidationUseCase = emptyValidationUseCase
		self.priceValidationUseCase = priceValidationUseCase
	}

	func getValidationErrors(nameService: String, price: String, duration: String) throws -> [String] {
		var errorMesssages = [String]()

		do {
			try checkValidNameService(nameService: nameService)
			try checkValidPrice(price: price)
			try checkValidDuration(duration: duration)

		} catch SettingsValidationError.emptyFieldNameService {
			errorMesssages.append(AppError.settingsValisationError(.emptyFieldNameService).errorDescription)

		} catch SettingsValidationError.emptyFieldPrice {
			errorMesssages.append(AppError.settingsValisationError(.emptyFieldPrice).errorDescription)

		} catch SettingsValidationError.emptyFieldDuration {
			errorMesssages.append(AppError.settingsValisationError(.emptyFieldDuration).errorDescription)

		} catch SettingsValidationError.notValidFieldPrice {
			errorMesssages.append(AppError.settingsValisationError(.notValidFieldPrice).errorDescription)
		}

		return errorMesssages
	}

	private func checkValidNameService(nameService: String) throws {
		if emptyValidationUseCase.isEmptyField(nameService) {
			throw SettingsValidationError.emptyFieldNameService
		}
	}

	private func checkValidPrice(price: String) throws {
		if emptyValidationUseCase.isEmptyField(price) {
			throw SettingsValidationError.emptyFieldPrice
		}

		if priceValidationUseCase.isValidPriceNumber(price) == false {
			throw SettingsValidationError.notValidFieldPrice
		}
	}

	func checkValidDuration(duration: String) throws {
		if emptyValidationUseCase.isEmptyField(duration) {
			throw SettingsValidationError.emptyFieldDuration
		}
	}
}
