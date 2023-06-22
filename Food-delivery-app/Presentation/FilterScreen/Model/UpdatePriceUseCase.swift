//
//  UpdatePriceUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 18.06.2023.
//

import Foundation

final class UpdatePriceUseCase {
    
    func updatePrice(_ price: String) -> Int? {
        return Int(price)
    }
}
