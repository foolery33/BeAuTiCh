//
//  ProfileModel.swift
//  Food-delivery-app
//
//  Created by Елена on 18.06.2023.
//

struct ProfileModel: Decodable {
	let id: String
	let email: String
	let fullName: String
	let avatar: Bool
	let phoneNumber: String?
	let isSubscribing: Bool
}
