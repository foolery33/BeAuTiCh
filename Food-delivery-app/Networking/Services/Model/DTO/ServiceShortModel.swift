//
//  ServiceShortModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

struct ServiceShortModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    var id: UUID
    var name: String
    
}
