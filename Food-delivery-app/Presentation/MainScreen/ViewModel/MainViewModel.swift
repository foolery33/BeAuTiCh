//
//  MainViewModel.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import Foundation

final class MainViewModel {
    
    weak var coordinator: MainCoordinator?
    
    private let getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase
    private let getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase
    private let getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase
    private let getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase
    private let getDateWithOffsetUseCase: GetDateWithOffsetUseCase
    private let isTodayUseCase: IsTodayUseCase
    
    private(set) var weekServiceNotes: [[NoteModel]] = [
        [
            NoteModel(customerName: "Мария Сафронова", serviceName: ["Маникюр", "Педикюр", "Наращивание"], time: "8:45", cost: 3500),
            NoteModel(customerName: "Ксения Павлова", serviceName: ["Стрижка"], time: "10:00", cost: 1500),
            NoteModel(customerName: "Альбина М.", serviceName: ["Коррекция бровей", "Окрашивание бровей", "Лазерная эпиляция"], time: "12:10", cost: 4500),
            NoteModel(customerName: "Не представилась", serviceName: ["Чистка лица"], time: "14:00", cost: 1000),
            NoteModel(customerName: "Инна Рапп", serviceName: ["Мезотерапия", "Массаж"], time: "15:40", cost: 3750),
            NoteModel(customerName: "Сергей Арсеньев", serviceName: ["Маникюр"], time: "17:20", cost: 650),
            NoteModel(customerName: "Никита", serviceName: ["Стрижка"], time: "18:00", cost: 700)
        ],
        [
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока","пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100)
        ],
        [
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100)
        ],
        [
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100)
        ],
        [
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100)
        ],
        [
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100)
        ],
        [
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100),
            NoteModel(customerName: "Привет привет", serviceName: ["пока", "пока", "пока"], time: "13:37", cost: 100)
        ]
    ]
    
    init(getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase, getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase, getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase, getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase, getDateWithOffsetUseCase: GetDateWithOffsetUseCase, isTodayUseCase: IsTodayUseCase) {
        self.getDaysOfWeekForDateUseCase = getDaysOfWeekForDateUseCase
        self.getWeekdayIndexForDateUseCase = getWeekdayIndexForDateUseCase
        self.getDayOfWeekByDateUseCase = getDayOfWeekByDateUseCase
        self.getDayOfMonthByDateUseCase = getDayOfMonthByDateUseCase
        self.getDateWithOffsetUseCase = getDateWithOffsetUseCase
        self.isTodayUseCase = isTodayUseCase
        
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
    
    var weekDates: [Date] = []
    var currentDayIndex: Int = 0
    var selectedDayIndex: Int = 0

	func goToDetailsMainScreen() {
		coordinator?.goToDetailsAppointmentScreen(model: AppointmentModel(id: UUID(), clientName: "Burava", services: [ServiceShortModel(id: UUID(), name: "Bubu"), ServiceShortModel(id: UUID(), name: "Babababababababa"), ServiceShortModel(id: UUID(), name: "Asdasdasd")], price: 340, startDateTime: "23.02.2023 15:00", endDateTime: "23.02.2023 20:00", status: .new))
	}
}
