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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        searchComponent = componentFactory.getSearchComponent()
    }
    
    func start() {
        goToSearchScreen()
    }
    
    private func goToSearchScreen() {
        searchComponent.searchViewModel.coordinator = self
        navigationController.pushViewController(searchComponent.searchViewController, animated: true)
    }
    
    func goToFilterScreen() {
        let filterComponent = componentFactory.getFilterComponent()
        filterComponent.filterViewModel.coordinator = self
        navigationController.pushViewController(filterComponent.filterViewController, animated: true)
    }
    
    func goBackToSearchScreen(priceFrom: Int?, priceTo: Int?, dateFrom: String?, dateTo: String?) {
        searchComponent.searchViewModel.startPrice = priceFrom
        searchComponent.searchViewModel.endPrice = priceTo
        searchComponent.searchViewModel.startDate = dateFrom
        searchComponent.searchViewModel.endDate = dateTo
        navigationController.popViewController(animated: true)
        searchComponent.searchViewController.getAppointmentList()
    }
    
}
