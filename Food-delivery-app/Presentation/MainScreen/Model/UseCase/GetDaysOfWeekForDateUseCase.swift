//
//  GetDaysOfWeekUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 05.06.2023.
//

import Foundation

final class GetDaysOfWeekForDateUseCase {
    
    func getDaysOfWeek(for date: Date) -> [Date] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ru_RU")

        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!

        var dates = [Date]()

        for day in 0...6 {
            guard let date = calendar.date(byAdding: .day, value: day, to: startOfWeek) else {
                continue
            }
            dates.append(date)
        }

        return dates
    }
    
}
