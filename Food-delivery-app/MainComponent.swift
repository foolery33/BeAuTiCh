//
//  MainComponent.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 31.05.2023.
//

import UIKit
import NeedleFoundation

final class MainComponent: BootstrapComponent {
    
    // MARK: - UseCases
    
    var getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase {
        shared {
            GetDaysOfWeekForDateUseCase()
        }
    }
    
    var getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase {
        shared {
            GetWeekdayIndexForDateUseCase()
        }
    }
    
    var getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase {
        shared {
            GetDayOfWeekByDateUseCase()
        }
    }
    
    var getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase {
        shared {
            GetDayOfMonthByDateUseCase()
        }
    }
    
    var getDateWithOffsetUseCase: GetDateWithOffsetUseCase {
        shared {
            GetDateWithOffsetUseCase()
        }
    }
    
    var isTodayUseCase: IsTodayUseCase {
        shared {
            IsTodayUseCase()
        }
    }
    
    // MARK: - Components
    
    var startComponent: StartComponent {
        shared {
            StartComponent(parent: self)
        }
    }
    
    var loginComponent: LoginComponent {
        shared {
            LoginComponent(parent: self)
        }
    }
    
    var registerComponent: RegisterComponent {
        shared {
            RegisterComponent(parent: self)
        }
    }
    var mainScreenComponent: MainScreenComponent {
        shared {
            MainScreenComponent(parent: self)
        }
    }
    
}
