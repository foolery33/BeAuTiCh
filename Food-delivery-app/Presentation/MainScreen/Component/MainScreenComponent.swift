//
//  MainScreenComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 04.06.2023.
//

import NeedleFoundation
import UIKit

protocol MainScreenComponentDependency: Dependency {
    var getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase { get }
    var getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase { get }
    var getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase { get }
    var getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase { get }
    var getDateWithOffsetUseCase: GetDateWithOffsetUseCase { get }
    var isTodayUseCase: IsTodayUseCase { get }
}

final class MainScreenComponent: Component<MainScreenComponentDependency> {
    var mainViewModel: MainViewModel {
        shared {
            MainViewModel(
                getDaysOfWeekForDateUseCase: dependency.getDaysOfWeekForDateUseCase,
                getWeekdayIndexForDateUseCase: dependency.getWeekdayIndexForDateUseCase,
                getDayOfWeekByDateUseCase: dependency.getDayOfWeekByDateUseCase,
                getDayOfMonthByDateUseCase: dependency.getDayOfMonthByDateUseCase,
                getDateWithOffsetUseCase: dependency.getDateWithOffsetUseCase,
                isTodayUseCase: dependency.isTodayUseCase
            )
        }
    }
    
    var mainViewController: UIViewController {
        MainViewController(viewModel: mainViewModel)
    }
}
