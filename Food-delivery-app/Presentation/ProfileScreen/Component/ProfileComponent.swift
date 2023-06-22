//
//  ProfileComponent.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import UIKit
import NeedleFoundation

protocol ProfileComponentDependency: Dependency {
	var profileRepository: ProfileRepository { get }
	var convertPhotoToDataUseCase: ConvertPhotoToDataUseCase { get }
}

final class ProfileComponent: Component<ProfileComponentDependency> {
	var profileViewModel: ProfileViewModel {
		shared {
			ProfileViewModel(
				profileRepository: dependency.profileRepository,
				convertPhotoToDataUseCase: dependency.convertPhotoToDataUseCase
			)
		}
	}

	var profileViewController: ProfileViewController {
		return ProfileViewController(viewModel: profileViewModel)
	}
}
