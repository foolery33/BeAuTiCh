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

	var convertPhotoToDataUseCase: ConvertPhotoToDataUseCase {
		shared {
			ConvertPhotoToDataUseCase()
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
    
    var convertISODateStringToDdMmYyyyUseCase: ConvertISODateStringToDdMmYyyyUseCase {
        shared {
            ConvertISODateStringToDdMmYyyyUseCase()
        }
    }

	var convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase {
		shared {
			ConvertDateToDdMmYyyyHhMmSsUseCase()
		}
	}
    
    var emptyValidationUseCase: EmptyValidationUseCase {
        shared {
            EmptyValidationUseCase()
        }
    }
    
    var emailValidationUseCase: EmailValidationUseCase {
        shared {
            EmailValidationUseCase()
        }
    }
    
    var getLoginValidationErrorUseCase: GetLoginValidationErrorUseCase {
        shared {
            GetLoginValidationErrorUseCase(
                emptyValidationUseCase: emptyValidationUseCase,
                emailValidationUseCase: emailValidationUseCase
            )
        }
    }
    
    var saveTokensUseCase: SaveTokensUseCase {
        shared {
            SaveTokensUseCase(tokenManagerRepository: tokenManagerRepository)
        }
    }
    
    var phoneNumberValidationUseCase: PhoneNumberValidationUseCase {
        shared {
            PhoneNumberValidationUseCase()
        }
    }
    
    var makeFullNameUseCase: MakeFullNameUseCase {
        shared {
            MakeFullNameUseCase()
        }
    }
    
    var getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase {
        shared {
            GetRegisterValidationErrorUseCase(
                emptyValidationUseCase: emptyValidationUseCase,
                emailValidationUseCase: emailValidationUseCase,
                phoneNumberValidationUseCase: phoneNumberValidationUseCase,
                passwordsEqualityValidationUseCase: passwordsEqualityValidationUseCase,
                passwordValidationUseCase: passwordValidationUseCase
            )
        }
    }
    
    var passwordsEqualityValidationUseCase: PasswordsEqualityValidationUseCase {
        shared {
            PasswordsEqualityValidationUseCase()
        }
    }
    
    var passwordValidationUseCase: PasswordValidationUseCase {
        shared {
            PasswordValidationUseCase()
        }
    }

	var convertStringToDateDdMmYyyyUseCase: ConvertStringToDateDdMmYyyyUseCase {
		shared {
			ConvertStringToDateDdMmYyyyUseCase()
		}
	}

	var convertToTimeHhMmSsUseCase: ConvertToTimeHhMmSsUseCase {
		shared {
			ConvertToTimeHhMmSsUseCase()
		}
	}

    
    var getSortedWeekAppointmentsUseCase: GetSortedWeekAppointmentsUseCase {
        shared {
            GetSortedWeekAppointmentsUseCase()
        }
    }
    
    var changeDateTimeStringToHhMmUseCase: ChangeDateTimeStringToHhMmUseCase {
        shared {
            ChangeDateTimeStringToHhMmUseCase()
        }
    }

	var convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase {
		shared {
			ConvertStringToDateDdMmYyyyHhMmSsUseCase()
		}
	}

	var priceValidationUseCase: PriceValidationUseCase {
		shared {
			PriceValidationUseCase()
		}
	}

	var getSettingsValidationErrorUseCase: GetSettingsValidationErrorUseCase {
		shared {
			GetSettingsValidationErrorUseCase(emptyValidationUseCase: emptyValidationUseCase, priceValidationUseCase: priceValidationUseCase)
		}
	}
    
    var convertDdMmYyyyHhMmSsToISOUseCase: ConvertDdMmYyyyHhMmSsToISOUseCase {
        shared {
            ConvertDdMmYyyyHhMmSsToISOUseCase()
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

	var profileRepository: ProfileRepository {
		shared {
			ProfileRepositoryImplementation(
				tokenManagerRepository: TokenManagerRepositoryImplementation()
			)
		}
	}
    
    var authRepository: AuthRepository {
        shared {
            AuthRepositoryImplementation()
        }
    }

	var subscribeRepository: SubscribeRepository {
		shared {
			SubscribeRepositoryImplementation(tokenManagerRepository: TokenManagerRepositoryImplementation()
			)
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

	var profileComponent: ProfileComponent {
		shared {
			ProfileComponent(parent: self)
		}
	}

	var detailsAppointment: DetailsAppointmentComponent {
		shared {
			DetailsAppointmentComponent(parent: self)
		}
	}

	var addAppointmentComponent: AddAppointmentComponent {
		shared {
			AddAppointmentComponent(parent: self)
		}
	}
	
	var editAppointmentComponent: EditAppointmentComponent {
		shared {
			EditAppointmentComponent(parent: self)
		}
	}
}
