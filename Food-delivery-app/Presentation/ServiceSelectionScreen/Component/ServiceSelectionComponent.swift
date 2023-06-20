//
//  File.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import UIKit
import NeedleFoundation

protocol ServiceSelectionComponentDependency: Dependency {
    var servicesRepository: ServicesRepository { get }
}

final class ServiceSelectionComponent: Component<ServiceSelectionComponentDependency> {
    var serviceSelectionViewModel: ServiceSelectionViewModel {
        shared {
            ServiceSelectionViewModel(
                servicesRepository: dependency.servicesRepository
            )
        }
    }
    
    var serviceSelectionViewController: ServiceSelectionViewController {
        return ServiceSelectionViewController(viewModel: serviceSelectionViewModel)
    }
}
