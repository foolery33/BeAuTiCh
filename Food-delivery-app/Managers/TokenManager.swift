//
//  TokenManager.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 17.06.2023.
//

import KeychainSwift

protocol TokenManagerRepository {
    func fetchAccessToken() -> String?
    func fetchRefreshToken() -> String?
    
    func setAccessToken(_ accessToken: String)
    func setRefreshToken(_ refreshToken: String)
    
    func clearData()
}

final class TokenManagerRepositoryImplementation: TokenManagerRepository {
    
    private enum KeyNames {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
    
    func fetchAccessToken() -> String? {
        KeychainSwift().get(KeyNames.accessToken)
    }
    
    func fetchRefreshToken() -> String? {
        KeychainSwift().get(KeyNames.refreshToken)
    }
    
    func setAccessToken(_ accessToken: String) {
        KeychainSwift().set(accessToken, forKey: KeyNames.accessToken)
    }
    
    func setRefreshToken(_ refreshToken: String) {
        KeychainSwift().set(refreshToken, forKey: KeyNames.refreshToken)
    }
    
    func clearData() {
        KeychainSwift().clear()
    }
}
