//
//  MainViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import Foundation

final class MainViewModel {
    
    weak var coordinator: MainCoordinator?
    
    private let appointmentRepository: AppointmentRepository
    
    private let getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase
    private let getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase
    private let getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase
    private let getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase
    private let getDateWithOffsetUseCase: GetDateWithOffsetUseCase
    private let isTodayUseCase: IsTodayUseCase
    private let getSortedWeekAppointmentsUseCase: GetSortedWeekAppointmentsUseCase
    private let changeDateTimeStringToHhMmUseCase: ChangeDateTimeStringToHhMmUseCase
    
    private(set) var weekAppointments: [[AppointmentModel]] = [
        [],
        [],
        [],
        [],
        [],
        [],
        []
    ]
    
    var weekDates: [Date] = []
    var currentDayIndex: Int = 0
    var selectedDayIndex: Int = 0

    var error: String = ""
    
    init(appointmentRepository: AppointmentRepository, getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase, getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase, getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase, getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase, getDateWithOffsetUseCase: GetDateWithOffsetUseCase, isTodayUseCase: IsTodayUseCase, getSortedWeekAppointmentsUseCase: GetSortedWeekAppointmentsUseCase, changeDateTimeStringToHhMmUseCase: ChangeDateTimeStringToHhMmUseCase) {
        self.appointmentRepository = appointmentRepository
        self.getDaysOfWeekForDateUseCase = getDaysOfWeekForDateUseCase
        self.getWeekdayIndexForDateUseCase = getWeekdayIndexForDateUseCase
        self.getDayOfWeekByDateUseCase = getDayOfWeekByDateUseCase
        self.getDayOfMonthByDateUseCase = getDayOfMonthByDateUseCase
        self.getDateWithOffsetUseCase = getDateWithOffsetUseCase
        self.isTodayUseCase = isTodayUseCase
        self.getSortedWeekAppointmentsUseCase = getSortedWeekAppointmentsUseCase
        self.changeDateTimeStringToHhMmUseCase = changeDateTimeStringToHhMmUseCase
        
        self.weekDates = getDaysOfWeekForDate(Date())
        self.currentDayIndex = getWeekdayIndexForDate(Date())
        self.selectedDayIndex = self.currentDayIndex
    }
    
    func getDaysOfWeekForDate(_ date: Date) -> [Date] {
        getDaysOfWeekForDateUseCase.getDaysOfWeek(for: date)
    }

    func getWeekdayIndexForDate(_ date: Date) -> Int {
        getWeekdayIndexForDateUseCase.getWeekdayIndex(for: date)
    }

    func getDayOfWeekByDate(_ date: Date, lettersCount: Int? = nil) -> String {
        getDayOfWeekByDateUseCase.getDayOfWeek(by: date, lettersCount: lettersCount)
    }

    func getDayOfMonthByDate(_ date: Date) -> Int {
        getDayOfMonthByDateUseCase.getDayOfMonthByDate(date: date)
    }

    func getDateWithOffset(from date: Date, byDays: Int) -> Date {
        getDateWithOffsetUseCase.getDateWithOffset(from: date, byDays: byDays)
    }

    func onLeftArrowButtonClicked() {
        weekDates = getDaysOfWeekForDate(
            getDateWithOffset(from: weekDates[0], byDays: -1)
        )
    }

    func onRightArrowButtonClicked() {
        weekDates = getDaysOfWeekForDate(
            getDateWithOffset(from: weekDates[weekDates.count - 1], byDays: 1)
        )
    }

    func isToday(_ date: Date) -> Bool {
        isTodayUseCase.isToday(date)
    }
    
    func getHhMmFormattedDateString(from dateString: String) -> String? {
        return changeDateTimeStringToHhMmUseCase.formatDate(dateString)
    }
    
    func goToDetailsMainScreen(appointment: AppointmentModel) {
		coordinator?.goToDetailsAppointmentScreen(model: appointment)
	}
    
    func getTimezoneAppointments() async -> Bool {
        do {
            // TODO: - Convert into double array
            let currentWeekAppointments = try await appointmentRepository.getTimezoneAppointments(startDate: "\(weekDates[0])", endDate: "\(weekDates[6])")
            weekAppointments = getSortedWeekAppointmentsUseCase.getWeekAppointments(from: currentWeekAppointments, dates: weekDates)
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return false
        }
    }
    
}
