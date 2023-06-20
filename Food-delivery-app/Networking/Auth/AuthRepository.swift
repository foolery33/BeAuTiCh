//
//  AuthRepository.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

protocol AuthRepository {
    func login(credentials: LoginCredentialsModel) async throws -> TokenPairModel
    func register(credentials: RegisterCredentialsModel) async throws -> TokenPairModel
}
