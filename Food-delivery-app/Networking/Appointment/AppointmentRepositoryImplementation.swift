//
//  AppointmentRepositoryImplementation.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Alamofire

final class AppointmentRepositoryImplementation: AppointmentRepository {

    private let baseURL = "http://94.250.248.129:10000/"
    private let interceptor = CustomRequestInterceptor()
    
    func getFilteredAppointments(parameters: FilteredAppointmentsParametersModel) async throws -> [AppointmentModel] {
        let url = baseURL + "api/appointments/filters"
        //print(parameters)
        let dataTask = AF.request(
            url,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(arrayEncoding: .noBrackets)),
            interceptor: interceptor
        ).serializingDecodable([AppointmentModel].self)
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.appointmentError(.modelError)
            case 401:
                throw AppError.appointmentError(.unauthorized)
            default:
                throw AppError.appointmentError(.serverError)
            }
        }
    }
    
    enum AppointmentError: LocalizedError, Identifiable {
        case unauthorized
        case serverError
        case modelError
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .unauthorized:
                return R.string.errors.unauthorized()
            case .serverError:
                return R.string.errors.server_error()
            case .modelError:
                return R.string.errors.model_error()
            }
        }
    }
    
}
