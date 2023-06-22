//
//  GetDateWithOffsetUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 05.06.2023.
//

import Foundation

final class GetDateWithOffsetUseCase {
    
    func getDateWithOffset(from date: Date, byDays days: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
}
