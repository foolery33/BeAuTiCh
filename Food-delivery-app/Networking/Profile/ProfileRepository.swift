//
//  ProfileRepository.swift
//  Food-delivery-app
//
//  Created by Елена on 18.06.2023.
//

import UIKit

protocol ProfileRepository {
	func getDataProfile() async throws -> ProfileModel
	func changeDataProfile(parameters: ChangeDataProfileModel) async throws
	func changePassword(parameters: ChangePassword) async throws
	func getAvatar() async throws -> Data
	func deleteAvatar() async throws
	func logout() async throws
	func uploadPhoto(imageData: Data, completion: @escaping (Result<Bool, AppError>) -> Void)
}
