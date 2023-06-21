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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImM2NWUxYTAyLTA2ZWQtNDI3MS05MjczLWY0ZDhmOTljYjUyZCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IldvcmtlciIsIm5iZiI6MTY4NzMzOTI0MiwiZXhwIjoxNjg3MzQwNDQyLCJpc3MiOiJKd3RJc3N1ZXIiLCJhdWQiOiJKd3RDbGllbnQifQ.UOMNODxXA1UoW3xuCRRkcTAiqjsl2ekP6bSU6TrJBZQ"
//        KeychainSwift().get(KeyNames.accessToken)
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
