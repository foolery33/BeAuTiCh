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
    
    func getTimezoneAppointments(startDate: String, endDate: String) async throws -> [AppointmentModel] {
        let url = baseURL + "api/appointments/timezone"
        let parameters: [String: String] = [
            "startDate": startDate,
            "endDate": endDate
        ]
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
            case 403:
                throw AppError.appointmentError(.forbiddenAccess)
            case 500:
                throw AppError.appointmentError(.serverError)
            default:
                throw AppError.appointmentError(.unexpectedError)
            }
        }
    }
    
    func getFilteredAppointments(parameters: FilteredAppointmentsParametersModel) async throws -> [AppointmentModel] {
        let url = baseURL + "api/appointments/filters"
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
            case 500:
                throw AppError.appointmentError(.serverError)
            default:
                throw AppError.appointmentError(.unexpectedError)
            }
        }
    }
    
    func changeAppointmentStatus(appointmentId: UUID, newStatus: StatusAppointmentModel) async throws -> String {
        let url = baseURL + "api/appointments/\(appointmentId)/status"
        let parameters = [
            "status": newStatus
        ]
        let dataTask = AF.request(
            url,
            method: .put,
            parameters: parameters,
            encoding: URLEncoding.queryString,
            interceptor: interceptor
        ).serializingString()
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 401:
                throw AppError.appointmentError(.unauthorized)
            case 403:
                throw AppError.appointmentError(.forbiddenAccess)
            case 500:
                throw AppError.appointmentError(.serverError)
            default:
                throw AppError.appointmentError(.unexpectedError)
            }
        }
    }

	func deleteAppointment(appointmentId: UUID) async throws -> String {
		let url = baseURL + "api/appointments/\(appointmentId)"

		let dataTask = AF.request(
			url,
			method: .delete,
			interceptor: interceptor
		).serializingString()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			switch requestStatusCode {
			case 401:
				throw AppError.appointmentError(.unauthorized)
			case 403:
				throw AppError.appointmentError(.forbiddenAccess)
			case 404:
				throw AppError.appointmentError(.notFound)
			case 500:
				throw AppError.appointmentError(.serverError)
			default:
				throw AppError.appointmentError(.unexpectedError)
			}
		}
	}
    
    func changeAppointmentInformation(appointmentId: UUID, newInfo: EditAppointmentModel) async throws -> Bool {
        let url = baseURL + "api/appointments/\(appointmentId)"
        let dataResponse = await AF.request(
            url,
            method: .put,
            parameters: newInfo,
            encoder: JSONParameterEncoder.default,
            interceptor: interceptor
        ).serializingDecodable(Empty.self).response
        switch dataResponse.response?.statusCode {
        case 200:
            return true
		case 400:
			throw AppError.appointmentError(.modelError)
        case 401:
            throw AppError.appointmentError(.unauthorized)
        case 403:
            throw AppError.appointmentError(.forbiddenAccess)
        case 500:
            throw AppError.appointmentError(.serverError)
        default:
            throw AppError.appointmentError(.unexpectedError)
        }
    }
    
    func createAppointment(newAppointmentModel: AddAppointmentModel) async throws {
        let url = baseURL + "api/appointments"
        let dataResponse = await AF.request(
            url,
            method: .post,
            parameters: newAppointmentModel,
            encoder: JSONParameterEncoder.default,
            interceptor: interceptor
        ).serializingDecodable(Empty.self).response
        switch dataResponse.response?.statusCode {
        case 200:
            return
		case 400:
			throw AppError.appointmentError(.modelError)
        case 401:
            throw AppError.appointmentError(.unauthorized)
        case 403:
            throw AppError.appointmentError(.forbiddenAccess)
        case 500:
            throw AppError.appointmentError(.serverError)
        default:
            throw AppError.appointmentError(.unexpectedError)
        }
    }
    
    enum AppointmentError:  LocalizedError, Identifiable {
        case unauthorized
        case serverError
        case modelError
        case forbiddenAccess
        case unexpectedError
		case notFound

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
            case .forbiddenAccess:
                return R.string.errors.forbidden_access()
            case .unexpectedError:
                return R.string.errors.unexpected_error()
			case .notFound:
				return R.string.errors.appointment_not_found()
            }
        }
    }
    
}
