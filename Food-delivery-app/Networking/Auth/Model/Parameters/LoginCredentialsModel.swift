//
//  LoginCredentialsModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

struct LoginCredentialsModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var email: String
    var password: String
    
}
