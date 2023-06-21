//
//  ProfileRepository.swift
//  Food-delivery-app
//
//  Created by Елена on 18.06.2023.
//

import UIKit

protocol ProfileRepository {
	func getDataProfile() async throws -> ProfileModel
	func changeDataProfile(parameters: ChangeDataProfileModel) async throws -> String
	func changePassword(parameters: ChangePassword) async throws -> Bool
	func getAvatar() async throws -> Data
	func changeAvatar(imageData: Data) async throws -> String
	func deleteAvatar() async throws -> String
	func logout() async throws -> String
	func uploadPhoto(imageData: Data, completion: @escaping (Result<Bool, AppError>) -> Void)
}
