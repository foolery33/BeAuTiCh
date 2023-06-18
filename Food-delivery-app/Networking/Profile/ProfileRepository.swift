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
	func getAvatarProfile() async throws -> UIImageView
	func changeAvatarProfile() async throws
	func deleteAvatarProfile() async throws
}