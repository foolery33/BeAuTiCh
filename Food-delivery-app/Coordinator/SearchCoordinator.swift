//
//  SearchCoordinator.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit

final class SearchCoordinator: CoordinatorProtocol {
 
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    private let searchComponent: SearchComponent
    private let filterComponent: FilterComponent
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        searchComponent = componentFactory.getSearchComponent()
        filterComponent = componentFactory.getFilterComponent()
    }
    
    func start() {
        goToSearchScreen()
    }
    
    private func goToSearchScreen() {
        searchComponent.searchViewModel.coordinator = self
        navigationController.pushViewController(searchComponent.searchViewController, animated: true)
    }
    
    func goToFilterScreen(priceFrom: Int?, priceTo: Int?, dateFrom: String?, dateTo: String?, selectedServiceIds: [UUID]) {
        filterComponent.filterViewModel.coordinator = self
        filterComponent.filterViewModel.priceFrom = priceFrom
        filterComponent.filterViewModel.priceTo = priceTo
        filterComponent.filterViewModel.dateFrom = dateFrom
        filterComponent.filterViewModel.dateTo = dateTo
        filterComponent.filterViewModel.selectedServiceIds = selectedServiceIds
        navigationController.pushViewController(filterComponent.filterViewController, animated: true)
    }

	func goToDetailsAppointmentScreen(model: AppointmentModel) {
		let detailsAppointmentComponent = componentFactory.getDetailsAppointment()
		detailsAppointmentComponent.detailsAppointmentViewModel.searchCoordinator = self
		detailsAppointmentComponent.detailsAppointmentViewModel.setAppointment(appointment: model)

		navigationController.pushViewController(detailsAppointmentComponent.detailsAppointmentViewController, animated: true)
	}
    
    func goBackToSearchScreen(priceFrom: Int?, priceTo: Int?, dateFrom: String?, dateTo: String?, selectedServiceIds: [UUID]) {
        searchComponent.searchViewModel.startPrice = priceFrom
        searchComponent.searchViewModel.endPrice = priceTo
        searchComponent.searchViewModel.startDate = dateFrom
        searchComponent.searchViewModel.endDate = dateTo
        searchComponent.searchViewModel.servicesId = selectedServiceIds
        navigationController.popViewController(animated: true)
    }
    
    func showServiceSelectionScreenSheet(selectedServiceIds: [UUID], from opener: ServiceSelectionOpener) {
        let serviceSelectionComponent = componentFactory.getServiceSelectionComponent()
        serviceSelectionComponent.serviceSelectionViewModel.searchCoordinator = self
        serviceSelectionComponent.serviceSelectionViewModel.selectedServiceIds = selectedServiceIds
        serviceSelectionComponent.serviceSelectionViewModel.opener = opener
        navigationController.present(serviceSelectionComponent.serviceSelectionViewController, animated: true)
    }
    
    func setSelectedServices(_ serviceIdList: [UUID]) {
        filterComponent.filterViewModel.selectedServiceIds = serviceIdList
    }

	func goBackSearchScreen() {
		navigationController.popViewController(animated: true)
	}
}
