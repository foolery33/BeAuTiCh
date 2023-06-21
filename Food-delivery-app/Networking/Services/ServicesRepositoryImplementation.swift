//
//  ServiceRepositoryImplementation.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 19.06.2023.
//

import Alamofire

final class ServicesRepositoryImplementation: ServicesRepository {
    
    private let baseURL = "http://94.250.248.129:10000/"
    private let interceptor = CustomRequestInterceptor()
    
    func getAllServices() async throws -> [ServiceModel] {
        let url = baseURL + "api/services/all"
        let dataTask = AF.request(
            url,
            interceptor: interceptor
        ).serializingDecodable([ServiceModel].self)
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.servicesError(.modelError)
            case 401:
                throw AppError.servicesError(.unauthorized)
            case 403:
                throw AppError.servicesError(.forbiddenAccess)
            default:
                throw AppError.servicesError(.serverError)
            }
        }
    }

	func getCustomServices() async throws -> [ServiceModel] {
		let url = baseURL + "api/services/custom"
		let dataTask = AF.request(
			url,
			interceptor: interceptor
		).serializingDecodable([ServiceModel].self)
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			switch requestStatusCode {
			case 200:
				throw AppError.servicesError(.modelError)
			case 401:
				throw AppError.servicesError(.unauthorized)
			case 403:
				throw AppError.servicesError(.forbiddenAccess)
			default:
				throw AppError.servicesError(.serverError)
			}
		}
	}

	func createCustomService(parameters: CreateService) async throws -> String {
		let url = baseURL + "api/services"
		let dataTask = AF.request(
			url,
			method: .post,
			parameters: parameters,
			encoder: JSONParameterEncoder.default,
			interceptor: interceptor
		).serializingString()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			switch requestStatusCode {
			case 200:
				throw AppError.servicesError(.modelError)
			case 401:
				throw AppError.servicesError(.unauthorized)
			case 403:
				throw AppError.servicesError(.forbiddenAccess)
			default:
				throw AppError.servicesError(.serverError)
			}
		}
	}

	func deleteCustomService(serviceId: UUID) async throws -> String {
		let url = baseURL + "api/services/\(serviceId)"
		let dataTask = AF.request(
			url,
			method: .delete,
			parameters: serviceId,
			encoder: JSONParameterEncoder.default,
			interceptor: interceptor
		).serializingString()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			switch requestStatusCode {
			case 200:
				throw AppError.servicesError(.modelError)
			case 401:
				throw AppError.servicesError(.unauthorized)
			case 403:
				throw AppError.servicesError(.forbiddenAccess)
			default:
				throw AppError.servicesError(.serverError)
			}
		}
	}


	func editCustomService(serviceId: UUID, parameters: CreateService) async throws -> String {
		let url = baseURL + "api/services/\(serviceId)"

		let dataTask = AF.request(
			url,
			method: .put,
			parameters: parameters,
			encoder: JSONParameterEncoder.default,
			interceptor: interceptor
		).serializingString()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			switch requestStatusCode {
			case 200:
				throw AppError.servicesError(.modelError)
			case 401:
				throw AppError.servicesError(.unauthorized)
			case 403:
				throw AppError.servicesError(.forbiddenAccess)
			default:
				throw AppError.servicesError(.serverError)
			}
		}
	}
    
    enum ServicesError: LocalizedError, Identifiable {
        case unauthorized
        case serverError
        case modelError
        case forbiddenAccess
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
            }
        }
    }
    
}
