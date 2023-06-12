//
//  NoteModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 09.06.2023.
//

import Foundation

struct NoteModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case customerName = "customerName"
        case serviceName = "serviceName"
        case time = "time"
        case cost = "cost"
    }
    
    init(customerName: String, serviceName: [String], time: String, cost: Int) {
        self.customerName = customerName
        self.serviceName = serviceName
        self.time = time
        self.cost = cost
    }
    
    var customerName: String
    var serviceName: [String]
    var time: String
    var cost: Int
    
}
