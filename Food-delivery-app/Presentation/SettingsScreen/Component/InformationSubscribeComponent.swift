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
}

final class InformationSubscribeComponent: Component<InformationSubscribeComponentDependency> {
    var settingsViewModel: SettingsViewModel {
        shared {
			SettingsViewModel(subscribeRepository: dependency.subscribeRepository)
        }
    }
    
    var informationSubscribeController: InformationSubscribeViewController {
        return InformationSubscribeViewController(viewModel: settingsViewModel)
    }
}
