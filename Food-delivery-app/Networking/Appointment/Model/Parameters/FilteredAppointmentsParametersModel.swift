//
//  GetAppointmentsParameters.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

struct FilteredAppointmentsParametersModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case startPrice = "startPrice"
        case endPrice = "endPrice"
        case startDate = "startDate"
        case endDate = "endDate"
        case servicesId = "servicesId"
    }
    
    init(startPrice: Int? = nil, endPrice: Int? = nil, startDate: String? = nil, endDate: String? = nil, servicesId: [String]) {
        self.startPrice = startPrice
        self.endPrice = endPrice
        self.startDate = startDate
        self.endDate = endDate
        self.servicesId = servicesId
    }
    
    var startPrice: Int?
    var endPrice: Int?
    var startDate: String?
    var endDate: String?
    var servicesId: [String]
    
}
