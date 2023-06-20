//
//  ProfileViewModel.swift
//  Food-delivery-app
//
//  Created by Елена on 17.06.2023.
//

import UIKit

class ProfileViewModel {
	private let profileRepository: ProfileRepository
	private let convertPhotoToDataUseCase: ConvertPhotoToDataUseCase

	weak var coordinator: ProfileCoordinator?

	init(profileRepository: ProfileRepository, convertPhotoToDataUseCase: ConvertPhotoToDataUseCase) {
		self.profileRepository = profileRepository
		self.convertPhotoToDataUseCase = convertPhotoToDataUseCase
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

	func changeDataProfile(with parameters: ChangeDataProfileModel) async -> Bool {
		do {
			_ = try await profileRepository.changeDataProfile(parameters: parameters)
			return true

		} catch (let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)

			} else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}

			return false
		}
	}

	func logout() async -> Bool {
		do {
			_ = try await profileRepository.logout()
			return true

		} catch (let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)

			} else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}

			return false
		}
	}

	func changePassword(parameters: ChangePassword) async -> Bool {
		do {
			_ = try await profileRepository.changePassword(parameters: parameters)
			return true

		} catch (let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)

			} else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}

			return false
		}
	}

	func getAvatar() async -> UIImage {
		do {
			let data = try await profileRepository.getAvatar()
			if let image = UIImage(data: data) {
				return image
			} else {
				return R.image.defaultAvatar() ?? UIImage()
			}

		} catch (let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)

			} else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}
		}

		return R.image.defaultAvatar() ?? UIImage()
	}

	func changeAvatar(imageUrl: URL) async {
		do {
			guard let fileData = readFileDataFromFileURL(fileURL: imageUrl) else { return }
			_ = try await profileRepository.changeAvatar(imageData: fileData)

		} catch (let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)

			} else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}
		}
	}

	func deleteAvatar() async -> Bool {
		do {
			_ = try await profileRepository.deleteAvatar()
			return true

		} catch (let error) {
			if let appError = error as? AppError {
				self.errorMessage.updateModel(with: appError.errorDescription)

			} else {
				self.errorMessage.updateModel(with: error.localizedDescription)
			}
		}

		return false
	}

	func goToAuthScreen() {
		coordinator?.goToAuthScreen()
	}

	private func readFileDataFromFileURL(fileURL: URL) -> Data? {
		do {
			let fileData = try Data(contentsOf: fileURL)
			return fileData
		} catch {
			print("Ошибка чтения файла: \(error.localizedDescription)")
			return nil
		}
	}
}
