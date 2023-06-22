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
    var selectedServiceShortModels: [ServiceShortModel] = []
    var error: String = ""
    var opener: ServiceSelectionOpener?
    
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
    
    func onServiceTagTapped(shortModel: ServiceShortModel) {
        if selectedServiceIds.contains(shortModel.id) {
            selectedServiceIds.removeAll(where: { $0 == shortModel.id })
            selectedServiceShortModels.removeAll(where: { $0 == shortModel })
        }
        else {
            selectedServiceIds.append(shortModel.id)
            selectedServiceShortModels.append(shortModel)
        }
    }
    
    func onServiceSelectionSheetDismissed() {
        print(selectedServiceIds)
        switch opener {
        case .searchScreen:
            searchCoordinator?.setSelectedServices(selectedServiceIds)
        case .editAppointmentScreen:
            mainCoordinator?.setSelectedServices(opener: .editAppointmentScreen, selectedServiceIds, selectedServiceShortModels)
        case .addAppointmentScreen:
            mainCoordinator?.setSelectedServices(opener: .addAppointmentScreen, selectedServiceIds, selectedServiceShortModels)
        case .none:
            return
        }
    }
    
}

enum ServiceSelectionOpener {
    case searchScreen
    case editAppointmentScreen
    case addAppointmentScreen
}
