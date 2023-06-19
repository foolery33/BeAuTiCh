//
//  FilterViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import Foundation

final class FilterViewModel {
    
    weak var coordinator: SearchCoordinator?
    
    private let updatePriceUseCase: UpdatePriceUseCase
    
    init(updatePriceUseCase: UpdatePriceUseCase) {
        self.updatePriceUseCase = updatePriceUseCase
    }
    
    var priceFrom: Int?
    var priceTo: Int?
    var dateFrom: String?
    var dateTo: String?
    
    func goBackToSearchScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    
    func updatePriceFrom(_ price: String) {
        if let intPrice = updatePriceUseCase.updatePrice(price) {
            priceFrom = intPrice
        }
        else {
            priceFrom = price.count > 0 ? Int(String(price.prefix(price.count - 1))) : nil
        }
    }
    
    func updatePriceTo(_ price: String) {
        if let intPrice = updatePriceUseCase.updatePrice(price) {
            priceTo = intPrice
        }
        else {
            priceTo = price.count > 0 ? Int(String(price.prefix(price.count - 1))) : nil
        }
    }
    
    func onSaveButtonTapped() {
        coordinator?.goBackToSearchScreen(priceFrom: priceFrom, priceTo: priceTo, dateFrom: dateFrom, dateTo: dateTo)
    }
    
}
