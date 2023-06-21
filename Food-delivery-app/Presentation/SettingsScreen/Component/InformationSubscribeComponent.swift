//
//  InformationSubscribeComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 15.06.2023.
//

import UIKit
import NeedleFoundation

protocol InformationSubscribeComponentDependency: Dependency {
	var subscribeRepository: SubscribeRepository { get }
	var convertStringToDateDdMmYyyyUseCase: ConvertStringToDateDdMmYyyyUseCase { get }
}

final class InformationSubscribeComponent: Component<InformationSubscribeComponentDependency> {
    var settingsViewModel: SettingsViewModel {
        shared {
			SettingsViewModel(subscribeRepository: dependency.subscribeRepository, convertStringToDateDdMmYyyyUseCase: dependency.convertStringToDateDdMmYyyyUseCase, servicesRepository: nil, convertToTimeHhMmSsUseCase: nil, getSettingsValidationErrorUseCase: nil)
        }
    }
    
    var informationSubscribeController: InformationSubscribeViewController {
        return InformationSubscribeViewController(viewModel: settingsViewModel)
    }
}
