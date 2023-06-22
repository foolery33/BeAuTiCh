//
//  SubscribeRepository.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

protocol SubscribeRepository {
	func isThereSubscription() async throws -> Bool
	func fetchInformationSubscribe() async throws -> SubscribeModel
	func changeStatusSubscribe(status: Bool) async throws
}
