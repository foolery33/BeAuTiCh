//
//  GetDayOfWeekByDateUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 05.06.2023.
//

import Foundation

final class GetDayOfWeekByDateUseCase {
    
    func getDayOfWeek(by date: Date, lettersCount: Int? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        if let lettersCount {
            let index = weekday.index(weekday.startIndex, offsetBy: lettersCount)
            return String(weekday[..<index]).capitalized
        }
        else {
            return weekday.capitalized
        }
    }
    
}
