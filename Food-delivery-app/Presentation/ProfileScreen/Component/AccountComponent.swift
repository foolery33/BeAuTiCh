//
//  ProfileComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import UIKit
import NeedleFoundation

protocol AccountComponentDependency: Dependency {

}

final class AccountComponent: Component<AccountComponentDependency> {
	var profileViewModel: ProfileViewModel {
		shared {
			ProfileViewModel()
		}
	}

	var profileViewController: ProfileViewController {
		return ProfileViewController(viewModel: profileViewModel)
	}
}
