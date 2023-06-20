//
//  AppError.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

enum AppError: LocalizedError, Identifiable {
    case appointmentError(AppointmentRepositoryImplementation.AppointmentError)
	case profileError(ProfileRepositoryImplementation.ProfileError)
    
    var id: String {
        self.errorDescription
    }
    var errorDescription: String {
        switch self {
        case .appointmentError(let error):
            return error.errorDescription
		case .profileError(let error):
			return error.errorDescription
        }
    }
    
}
