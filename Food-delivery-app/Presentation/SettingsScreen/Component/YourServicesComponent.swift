//
//  YourServicesComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import NeedleFoundation
import UIKit

protocol YourServicesComponentDependency: Dependency {
	var subscribeRepository: SubscribeRepository { get }
	var servicesRepository: ServicesRepository { get }
	var convertToTimeHhMmSsUseCase: ConvertToTimeHhMmSsUseCase { get }
	var getSettingsValidationErrorUseCase: GetSettingsValidationErrorUseCase { get }
}

final class YourServicesComponent: Component<YourServicesComponentDependency> {
    var settingViewModel: SettingsViewModel {
        shared {
			SettingsViewModel(subscribeRepository: dependency.subscribeRepository, convertStringToDateDdMmYyyyUseCase: nil, servicesRepository: dependency.servicesRepository, convertToTimeHhMmSsUseCase: dependency.convertToTimeHhMmSsUseCase, getSettingsValidationErrorUseCase: dependency.getSettingsValidationErrorUseCase)
        }
    }
    
    var yourServicesViewController: YourServicesViewController {
        return YourServicesViewController(viewModel: settingViewModel)
    }
}
