//
//  GetWeekdayIndexForDateUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 05.06.2023.
//

import Foundation

final class GetWeekdayIndexForDateUseCase {
    
    func getWeekdayIndex(for date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date).capitalized

        switch dayOfWeek {
        case "Понедельник":
            return 0
        case "Вторник":
            return 1
        case "Среда":
            return 2
        case "Четверг":
            return 3
        case "Пятница":
            return 4
        case "Суббота":
            return 5
        case "Воскресенье":
            return 6
        default:
            return -1
        }
    }
    
}
