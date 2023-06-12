//
//  IsTodayUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 06.06.2023.
//

import Foundation

final class IsTodayUseCase {
    
    func isToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let otherDate = calendar.startOfDay(for: date)
        return today == otherDate
    }
    
}
