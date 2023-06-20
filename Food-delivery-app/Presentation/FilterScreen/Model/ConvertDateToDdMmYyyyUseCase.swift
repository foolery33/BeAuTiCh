//
//  ConvertDateToDdMmYyyyUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Foundation

final class ConvertDateToDdMmYyyyUseCase {
    
    func convert(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
}
