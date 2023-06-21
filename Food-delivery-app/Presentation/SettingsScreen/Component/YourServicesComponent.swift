//
//  YourServicesComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import NeedleFoundation
import UIKit

protocol YourServicesComponentDependency: Dependency {
    
}

final class YourServicesComponent: Component<YourServicesComponentDependency> {
    var settingViewModel: SettingsViewModel {
        shared {
			SettingsViewModel(subscribeRepository: nil)
        }
    }
    
    var yourServicesViewController: YourServicesViewController {
        return YourServicesViewController(viewModel: settingViewModel)
    }
}
