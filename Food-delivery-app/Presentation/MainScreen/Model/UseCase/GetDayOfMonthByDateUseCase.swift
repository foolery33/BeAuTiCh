//
//  GetDayOfMonthByDateUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 05.06.2023.
//

import Foundation

final class GetDayOfMonthByDateUseCase {
    
    func getDayOfMonthByDate(date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return Int(dateFormatter.string(from: date)) ?? 1
    }
    
}
