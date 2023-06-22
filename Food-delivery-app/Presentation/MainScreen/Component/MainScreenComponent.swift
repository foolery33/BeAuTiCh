//
//  MainScreenComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import NeedleFoundation
import UIKit

protocol MainScreenComponentDependency: Dependency {
    var appointmentRepository: AppointmentRepository { get }
    var getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase { get }
    var getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase { get }
    var getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase { get }
    var getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase { get }
    var getDateWithOffsetUseCase: GetDateWithOffsetUseCase { get }
    var isTodayUseCase: IsTodayUseCase { get }
    var getSortedWeekAppointmentsUseCase: GetSortedWeekAppointmentsUseCase { get }
    var changeDateTimeStringToHhMmUseCase: ChangeDateTimeStringToHhMmUseCase { get }
}

final class MainScreenComponent: Component<MainScreenComponentDependency> {
    var mainViewModel: MainViewModel {
        shared {
            MainViewModel(
                appointmentRepository: dependency.appointmentRepository,
                getDaysOfWeekForDateUseCase: dependency.getDaysOfWeekForDateUseCase,
                getWeekdayIndexForDateUseCase: dependency.getWeekdayIndexForDateUseCase,
                getDayOfWeekByDateUseCase: dependency.getDayOfWeekByDateUseCase,
                getDayOfMonthByDateUseCase: dependency.getDayOfMonthByDateUseCase,
                getDateWithOffsetUseCase: dependency.getDateWithOffsetUseCase,
                isTodayUseCase: dependency.isTodayUseCase,
                getSortedWeekAppointmentsUseCase: dependency.getSortedWeekAppointmentsUseCase, changeDateTimeStringToHhMmUseCase: dependency.changeDateTimeStringToHhMmUseCase
            )
        }
    }
    
    var mainViewController: UIViewController {
        MainViewController(viewModel: mainViewModel)
    }
}
