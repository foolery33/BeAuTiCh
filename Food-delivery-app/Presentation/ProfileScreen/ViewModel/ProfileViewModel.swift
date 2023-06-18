//
//  ProfileViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

class ProfileViewModel {
	private let profileRepository: ProfileRepository

	weak var coordinator: ProfileCoordinator?

	init(profileRepository: ProfileRepository) {
		self.profileRepository = profileRepository
	}

	var profile = Observable<ProfileModel>()
	var errorMessage = Observable<String>()

	func fetchDataProfile() async {
		do {
			let profile = try await profileRepository.getDataProfile()
			self.profile.updateModel(with: profile)

		} catch (let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)

			} else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}
		}
	}
}
