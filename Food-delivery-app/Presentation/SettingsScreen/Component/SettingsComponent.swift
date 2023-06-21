//
//  SettingsComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 13.06.2023.
//

import UIKit
import NeedleFoundation

protocol SettingsComponentDependency: Dependency {
    
}

final class SettingsComponent: Component<SettingsComponentDependency> {
    var settingsViewModel: SettingsViewModel {
        shared {
			SettingsViewModel(subscribeRepository: nil, convertStringToDateDdMmYyyyUseCase: nil, servicesRepository: nil)
        }
    }
    
    var settingsViewController: SettingsViewController {
        return SettingsViewController(viewModel: settingsViewModel)
    }
}
