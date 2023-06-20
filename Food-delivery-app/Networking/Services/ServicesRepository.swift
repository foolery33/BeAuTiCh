//
//  ServicesRepository.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import Foundation

protocol ServicesRepository {
    
    func getAllServices() async throws -> [ServiceModel]
    
}
