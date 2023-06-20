//
//  FilterComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import UIKit
import NeedleFoundation

protocol FilterComponentDependency: Dependency {
    var updatePriceUseCase: UpdatePriceUseCase { get }
    var convertDateToISOUseCase: ConvertDateToISOUseCase { get }
    var convertDateToDdMmYyyyUseCase: ConvertDateToDdMmYyyyUseCase { get }
    var convertISODateStringToDdMmYyyyUseCase: ConvertISODateStringToDdMmYyyyUseCase { get }
}

final class FilterComponent: Component<FilterComponentDependency> {
    var filterViewModel: FilterViewModel {
        shared {
            FilterViewModel(
                updatePriceUseCase: dependency.updatePriceUseCase,
                convertDateToISOUseCase: dependency.convertDateToISOUseCase,
                convertDateToDdMmYyyyUseCase: dependency.convertDateToDdMmYyyyUseCase,
                convertISODateStringToDdMmYyyyUseCase: dependency.convertISODateStringToDdMmYyyyUseCase
            )
        }
    }
    
    var filterViewController: FilterViewController {
        return FilterViewController(viewModel: filterViewModel)
    }
}
