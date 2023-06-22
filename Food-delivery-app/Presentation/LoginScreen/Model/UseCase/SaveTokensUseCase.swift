//
//  SaveTokensUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class SaveTokensUseCase {
    
    private let tokenManagerRepository: TokenManagerRepository
    
    init(tokenManagerRepository: TokenManagerRepository) {
        self.tokenManagerRepository = tokenManagerRepository
    }
    
    func saveTokens(tokenPairModel: TokenPairModel) {
        tokenManagerRepository.setAccessToken(tokenPairModel.accessToken)
        tokenManagerRepository.setRefreshToken(tokenPairModel.refreshToken)
    }
    
}
