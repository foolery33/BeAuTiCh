//
//  ServiceModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import Foundation

struct ServiceModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case duration = "duration"
    }
    
    init(id: UUID, name: String, price: Double, duration: String) {
        self.id = id
        self.name = name
        self.price = price
        self.duration = duration
    }
    
    var id: UUID
    var name: String
    var price: Double
    var duration: String
    
}
