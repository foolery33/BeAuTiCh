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
    
    var convertISOToReadableDateAndTimeUseCase: ConvertISOToReadableDateAndTimeUseCase {
        shared {
            ConvertISOToReadableDateAndTimeUseCase()
        }
    }
    
    var getFilteredAppointmentListUseCase: GetFilteredAppointmentListUseCase {
        shared {
            GetFilteredAppointmentListUseCase()
        }
    }
    
    var updatePriceUseCase: UpdatePriceUseCase {
        shared {
            UpdatePriceUseCase()
        }
    }
    
    var convertDateToISOUseCase: ConvertDateToISOUseCase {
        shared {
            ConvertDateToISOUseCase()
        }
    }
    
    var convertDateToDdMmYyyyUseCase: ConvertDateToDdMmYyyyUseCase {
        shared {
            ConvertDateToDdMmYyyyUseCase()
        }
    }
    
    // MARK: - Repositories
    
    var tokenManagerRepository: TokenManagerRepository {
        shared {
            TokenManagerRepositoryImplementation()
        }
    }
    
    var appointmentRepository: AppointmentRepository {
        shared {
            AppointmentRepositoryImplementation()
        }
    }
    
    var servicesRepository: ServicesRepository {
        shared {
            ServicesRepositoryImplementation()
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
    var searchComponent: SearchComponent {
        shared {
            SearchComponent(parent: self)
        }
    }
    
    var settingsComponent: SettingsComponent {
        shared {
            SettingsComponent(parent: self)
        }
    }
    
    var informationSubscribeComponent: InformationSubscribeComponent {
        shared {
            InformationSubscribeComponent(parent: self)
        }
    }
    
    var yourServicesComponent: YourServicesComponent {
        shared {
            YourServicesComponent(parent: self)
        }
    }

	var filterComponent: FilterComponent {
		shared {
			FilterComponent(parent: self)
		}
	}
    
    var serviceSelectionComponent: ServiceSelectionComponent {
        shared {
            ServiceSelectionComponent(parent: self)
        }
    }
}
