//
//  GetSortedWeekAppointmentsUseCase.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 21.06.2023.
//

import Foundation

final class GetSortedWeekAppointmentsUseCase {
    
    func getWeekAppointments(from appointments: [AppointmentModel], dates: [Date]) -> [[AppointmentModel]] {
        
        var result: [[AppointmentModel]] = []
        
        for date in 0..<dates.count {
            result.append([])
            for appointment in 0..<appointments.count {
                if formatDate(appointments[appointment].startDateTime) == convertDateToString(dates[date]) {
                    result[date].append(appointments[appointment])
                }
            }
            if result[date].count > 1 {
                result[date] = sortAppointments(appointments: result[date])
            }
        }
        
        return result
        
    }
    
    // Функция, принимающая на вход строку-дату в формате "yyyy-MM-dd'T'HH:mm:ss"
    // и возвращающая строку-дату в формате "yyyy/MM/dd"
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = .current
        guard let date = dateFormatter.date(from: dateString) else {
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            guard let newDate = newDateFormatter.date(from: dateString) else { return nil }
            newDateFormatter.dateFormat = "yyyy/MM/dd"
            return newDateFormatter.string(from: newDate)
        }
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    // Функция, сортирующая уроки в конкретный день в заданном порядке
    func sortAppointments(appointments: [AppointmentModel]) -> [AppointmentModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = .current
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return appointments.sorted { appointment1, appointment2 in
            let date1 = dateFormatter.date(from: appointment1.startDateTime) ?? newDateFormatter.date(from: appointment1.startDateTime)!
            let date2 = dateFormatter.date(from: appointment2.startDateTime) ?? newDateFormatter.date(from: appointment2.startDateTime)!
            return date1 < date2
        }
    }
    
    func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
}
