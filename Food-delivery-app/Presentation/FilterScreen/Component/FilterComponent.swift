//
//  FilterComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import UIKit
import NeedleFoundation

protocol FilterComponentDependency: Dependency {
    
}

final class FilterComponent: Component<FilterComponentDependency> {
    var filterViewModel: FilterViewModel {
        shared {
            FilterViewModel()
        }
    }
    
    var filterViewController: UIViewController {
        return FilterViewController(viewModel: filterViewModel)
    }
}
