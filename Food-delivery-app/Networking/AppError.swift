//
//  AppError.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

enum AppError: LocalizedError, Identifiable {
    case appointmentError(AppointmentRepositoryImplementation.AppointmentError)
    case servicesError(ServicesRepositoryImplementation.ServicesError)
    case authError(AuthRepositoryImplementation.AuthError)
	case profileError(ProfileRepositoryImplementation.ProfileError)
	case subscribeError(SubscribeRepositoryImplementation.SubscribeError)
	case settingsValisationError(SettingsValidationError)

    var id: String {
        self.errorDescription
    }
    var errorDescription: String {
        switch self {
        case .appointmentError(let error):
            return error.errorDescription
		case .profileError(let error):
			return error.errorDescription
        case .servicesError(let error):
            return error.errorDescription
        case .authError(let error):
            return error.errorDescription
		case .subscribeError(let error):
			return error.errorDescription
		case .settingsValisationError(let error):
			return error.errorDescription
        }
    }
    
}
