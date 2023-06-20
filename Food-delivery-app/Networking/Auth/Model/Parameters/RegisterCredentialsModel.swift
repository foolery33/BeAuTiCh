//
//  RegisterCredentialsModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

struct RegisterCredentialsModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case fullName = "fullName"
        case password = "password"
        case phoneNumber = "phoneNumber"
    }
    
    init(email: String, fullName: String, password: String, phoneNumber: String) {
        self.email = email
        self.fullName = fullName
        self.password = password
        self.phoneNumber = phoneNumber
    }
    
    var email: String
    var fullName: String
    var password: String
    var phoneNumber: String
    
}
