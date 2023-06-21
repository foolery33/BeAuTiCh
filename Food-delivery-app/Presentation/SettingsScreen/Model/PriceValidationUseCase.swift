//
//  PriceValidationUseCase.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import Foundation

final class PriceValidationUseCase {

	func isValidPriceNumber(_ price: String) -> Bool {
		let priceRegex = "^[0-9.,]+$"
		let pricePredicate = NSPredicate(format: "SELF MATCHES %@", priceRegex)

		return pricePredicate.evaluate(with: price)
	}

}

