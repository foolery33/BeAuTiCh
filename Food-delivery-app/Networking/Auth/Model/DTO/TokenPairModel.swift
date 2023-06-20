//
//  TokenPairModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 18.06.2023.
//

import Foundation

struct TokenPairModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    var accessToken: String
    var refreshToken: String
    
}
