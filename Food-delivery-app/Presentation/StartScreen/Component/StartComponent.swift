//
//  StartComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import UIKit
import NeedleFoundation

protocol StartComponentDependency: Dependency {
    
}

final class StartComponent: Component<StartComponentDependency> {
    var startViewModel: StartViewModel {
        shared {
            StartViewModel()
        }
    }
    
    var startViewController: UIViewController {
        return StartViewController(viewModel: startViewModel)
    }
}
