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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSearchScreen()
    }
    
    private func goToSearchScreen() {
        let searchComponent = componentFactory.getSearchComponent()
        searchComponent.searchViewModel.coordinator = self
        navigationController.pushViewController(searchComponent.searchViewController, animated: true)
    }
    
    func goToFilterScreen() {
        let filterComponent = componentFactory.getFilterComponent()
        filterComponent.filterViewModel.coordinator = self
        navigationController.pushViewController(filterComponent.filterViewController, animated: true)
    }
    
}
