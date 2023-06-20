//
//  ServiceSelectionViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import Foundation

final class ServiceSelectionViewModel {
    
    weak var searchCoordinator: SearchCoordinator?
	weak var mainCoordinator: MainCoordinator?

    private let servicesRepository: ServicesRepository
    
    var servicesList: [ServiceModel] = []
    var selectedServiceIds: [UUID] = []
    var error: String = ""
    
    init(servicesRepository: ServicesRepository) {
        self.servicesRepository = servicesRepository
    }
    
    func getAllServices() async -> Bool {
        do {
            servicesList = try await servicesRepository.getAllServices()
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return false
        }
    }
    
    func onServiceTagTapped(id: UUID) {
        if selectedServiceIds.contains(id) {
            selectedServiceIds.removeAll(where: { $0 == id })
        }
        else {
            selectedServiceIds.append(id)
        }
    }
    
    func onServiceSelectionSheetDismissed() {
        searchCoordinator?.setSelectedServices(selectedServiceIds)
    }
    
}
