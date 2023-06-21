//
//  SubscribeRepositoryImplementation.swift
//  Food-delivery-app
//
//  Created by Елена on 21.06.2023.
//

import Alamofire

class SubscribeRepositoryImplementation: SubscribeRepository {
	// MARK: - Private properties
	private let tokenManagerRepository: TokenManagerRepository
	private let baseURL = "http://94.250.248.129:10000/api/subscribe"
	private let interceptor: CustomRequestInterceptor
	private let session: Alamofire.Session

	init(tokenManagerRepository: TokenManagerRepository) {
		self.tokenManagerRepository = tokenManagerRepository
		session = .default
		interceptor = CustomRequestInterceptor()
	}

	enum SubscribeError: LocalizedError, Identifiable {
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

	func isThereSubscription() async throws -> Bool {
		let url = baseURL
		let dataTask = AF.request(
			url,
			interceptor: interceptor
		).serializingDecodable(Bool.self)
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

	func fetchInformationSubscribe() async throws -> SubscribeModel {
		let url = baseURL + "details"
		let dataTask = session.request(
			url,
			interceptor: interceptor
		).serializingDecodable(SubscribeModel.self)
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

	func changeStatusSubscribe(status: Bool) async throws -> String {
		let url = baseURL
		let dataTask = session.request(
			url,
			method: .put,
			parameters: status,
			encoder: JSONParameterEncoder.default,
			interceptor: interceptor
		).serializingString()
		await print(dataTask.response.request)
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
}
