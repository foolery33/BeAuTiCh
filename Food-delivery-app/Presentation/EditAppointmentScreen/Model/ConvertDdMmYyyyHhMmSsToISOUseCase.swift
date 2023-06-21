//
//  ConvertDdMmYyyyHhMmSsToISOUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 22.06.2023.
//

import Foundation

final class ConvertDdMmYyyyHhMmSsToISOUseCase {
    
    func convert(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter.string(from: date)
        }

        return nil
    }
    
}
