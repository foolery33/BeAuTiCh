//
//  ServicesRepository.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import Foundation

protocol ServicesRepository {
    
    func getAllServices() async throws -> [ServiceModel]
	func getCustomServices() async throws -> [ServiceModel]
	func getService(serviceId: UUID) async throws -> ServiceModel
	func createCustomService(parameters: CreateService) async throws -> String
	func deleteCustomService(serviceId: UUID) async throws -> String
}
