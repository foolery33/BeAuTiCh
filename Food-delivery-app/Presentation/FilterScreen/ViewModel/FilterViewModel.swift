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
    private let convertDateToISOUseCase: ConvertDateToISOUseCase
    private let convertDateToDdMmYyyyUseCase: ConvertDateToDdMmYyyyUseCase
    private let convertISODateStringToDdMmYyyyUseCase: ConvertISODateStringToDdMmYyyyUseCase
    
    init(updatePriceUseCase: UpdatePriceUseCase, convertDateToISOUseCase: ConvertDateToISOUseCase, convertDateToDdMmYyyyUseCase: ConvertDateToDdMmYyyyUseCase, convertISODateStringToDdMmYyyyUseCase: ConvertISODateStringToDdMmYyyyUseCase) {
        self.updatePriceUseCase = updatePriceUseCase
        self.convertDateToISOUseCase = convertDateToISOUseCase
        self.convertDateToDdMmYyyyUseCase = convertDateToDdMmYyyyUseCase
        self.convertISODateStringToDdMmYyyyUseCase = convertISODateStringToDdMmYyyyUseCase
    }
    
    var priceFrom: Int?
    var priceTo: Int?
    var dateFrom: String?
    var dateTo: String?
    
    var selectedServiceIds: [UUID] = []
    
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
    
    func updateDateFrom(_ date: String) {
        dateFrom = convertDateToISOUseCase.convert(date)
    }
    
    func updateDateTo(_ date: String) {
        dateTo = convertDateToISOUseCase.convert(date)
    }
    
    func onSaveButtonTapped() {
        coordinator?.goBackToSearchScreen(priceFrom: priceFrom, priceTo: priceTo, dateFrom: dateFrom, dateTo: dateTo, selectedServiceIds: selectedServiceIds)
    }
    
    func showServiceSelectionScreenSheet() {
        coordinator?.showServiceSelectionScreenSheet(selectedServiceIds: selectedServiceIds, from: .searchScreen)
    }
    
    func convertDateToDdMmYyyy(_ date: Date) -> String {
        return convertDateToDdMmYyyyUseCase.convert(date)
    }
    
    func convertISODateStringToDdMmYyyy(_ dateString: String) -> String {
        return convertISODateStringToDdMmYyyyUseCase.convert(dateString) ?? ""
    }
    
}
