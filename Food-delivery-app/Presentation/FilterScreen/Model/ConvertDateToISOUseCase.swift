//
//  ConvertDateToISOUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class ConvertDateToISOUseCase {
    
    func convert(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
}
