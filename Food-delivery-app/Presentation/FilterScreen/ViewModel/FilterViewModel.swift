//
//  FilterViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import Foundation

final class FilterViewModel {
    
    weak var coordinator: SearchCoordinator?
    
    func goBackToSearchScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    
}
