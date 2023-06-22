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
			case .notFound:
				return R.string.errors.not_fount_subscribe()
			}
		}
	}

	func isThereSubscription() async throws -> Bool {
		let url = baseURL
		let dataResponse = AF.request(
			url,
			interceptor: interceptor
		).serializingDecodable(Bool.self)
		do {
			return try await dataResponse.value
		} catch {
			let requestStatusCode = await dataResponse.response.response?.statusCode
			switch requestStatusCode {
			case 200:
				throw AppError.subscribeError(.modelError)
			case 401:
				throw AppError.subscribeError(.unauthorized)
			default:
				throw AppError.subscribeError(.serverError)
			}
		}
	}

	func fetchInformationSubscribe() async throws -> SubscribeModel {
		let url = baseURL + "/details"
		let dataResponse = session.request(
			url,
			interceptor: interceptor
		).serializingDecodable(SubscribeModel.self)
		do {
			return try await dataResponse.value
		} catch {
			let requestStatusCode = await dataResponse.response.response?.statusCode
			switch requestStatusCode {
			case 200:
				throw AppError.subscribeError(.modelError)
			case 401:
				throw AppError.subscribeError(.unauthorized)
			case 404:
				throw AppError.subscribeError(.notFound)
			default:
				throw AppError.subscribeError(.serverError)
			}
		}
	}

	func changeStatusSubscribe(status: Bool) async throws {
		let url = baseURL
		let parameters: Parameters = [
			"isSubscribing" : "\(status)"
		]

		let dataResponse = await session.request(
			url,
			method: .put,
			parameters: parameters,
			encoding: URLEncoding.queryString,
			interceptor: interceptor
		).serializingDecodable(Empty.self).response
		switch dataResponse.response?.statusCode {
		case 200:
			return
		case 401:
			throw AppError.subscribeError(.unauthorized)
		case 404:
			throw AppError.subscribeError(.modelError)
		case 500:
			throw AppError.appointmentError(.serverError)
		default:
			throw AppError.appointmentError(.unexpectedError)
		}
	}
}
