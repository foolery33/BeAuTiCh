//
//  EmptyValidationUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class EmptyValidationUseCase {
    func isEmptyField(_ field: String) -> Bool {
        return field.isEmpty
    }
}
