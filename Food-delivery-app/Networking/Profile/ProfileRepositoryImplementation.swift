//
//  ProfileRepositoryImplementation.swift
//  Food-delivery-app
//
//  Created by Елена on 18.06.2023.
//

import Alamofire
import UIKit

final class ProfileRepositoryImplementation: ProfileRepository {
	// MARK: - Private properties
	private let tokenManagerRepository: TokenManagerRepository
	private let baseURL = "http://94.250.248.129:10000/"
	private let interceptor: CustomRequestInterceptor
	private let session: Alamofire.Session
	
	init(tokenManagerRepository: TokenManagerRepository) {
		self.tokenManagerRepository = tokenManagerRepository
		session = .default
		interceptor = CustomRequestInterceptor()
	}
	
	enum ProfileError: LocalizedError, Identifiable {
		case unauthorized
		case serverError
		case modelError
		case notCorrectOldPassword
		case photoNotFound
		
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
			case .notCorrectOldPassword:
				return R.string.errors.not_correct_old_password()
			case .photoNotFound:
				return R.string.errors.photo_not_found()
			}
		}
	}
	
	func getDataProfile() async throws -> ProfileModel {
		let url = baseURL + "api/profile"
		let dataResponse = session.request(
			url,
			interceptor: interceptor
		).serializingDecodable(ProfileModel.self)
		do {
			return try await dataResponse.value
		} catch {
			let requestStatusCode = await dataResponse.response.response?.statusCode
			
			switch requestStatusCode {
			case 200:
				throw AppError.profileError(.modelError)
			case 401:
				throw AppError.profileError(.unauthorized)
			default:
				throw AppError.profileError(.serverError)
			}
		}
	}
	
	func changeDataProfile(parameters: ChangeDataProfileModel) async throws {
		let url = baseURL + "api/profile"
		let dataResponse = await session.request(
			url,
			method: .patch,
			parameters: parameters,
			encoder: JSONParameterEncoder.default,
			interceptor: interceptor
		).serializingDecodable(Empty.self).response
		let requestStatusCode = dataResponse.response?.statusCode

		switch requestStatusCode {
		case 200:
			return
		case 400:
			throw AppError.profileError(.modelError)
		case 401:
			throw AppError.profileError(.unauthorized)
		default:
			throw AppError.profileError(.serverError)
		}
	}
	
	func changePassword(parameters: ChangePassword) async throws {
		let url = baseURL + "api/profile/password"
		
		let dataResponse = await session.request(
			url,
			method: .put,
			parameters: parameters,
			encoder: JSONParameterEncoder.default,
			interceptor: interceptor
		).serializingDecodable(Empty.self).response

		switch  dataResponse.response?.statusCode {
		case 200:
			return
		case 400:
			throw AppError.profileError(.notCorrectOldPassword)
		case 401:
			throw AppError.profileError(.unauthorized)
		default:
			throw AppError.profileError(.serverError)
		}
	}
	
	func getAvatar() async throws -> Data {
		let url = baseURL + "api/profile/avatar"
		let dataResponse = AF.request(
			url,
			interceptor: interceptor).serializingData()
		do {
			return try await dataResponse.value
		} catch {
			let requestStatusCode = await dataResponse.response.response?.statusCode
			switch requestStatusCode {
			case 400:
				throw AppError.profileError(.modelError)
			case 401:
				throw AppError.profileError(.unauthorized)
			case 404:
				throw AppError.profileError(.photoNotFound)
			default:
				throw AppError.profileError(.serverError)
			}
		}
	}

	func uploadPhoto(imageData: Data, completion: @escaping (Result<Bool, AppError>) -> Void) {
		let url = baseURL + "api/profile/avatar"
		let headers: HTTPHeaders = [
			"Authorization": "Bearer \(TokenManagerRepositoryImplementation().fetchAccessToken()!)"
				]

		session.upload(multipartFormData: { multipartFormData in
			multipartFormData.append(imageData, withName: "avatar", fileName: "image.png", mimeType: "image/png")
		}, to: url, method: .post, headers: headers).response { response in
			switch response.result {
			case .success:
				switch response.response?.statusCode {
				case 200:
					completion(.success(true))
				case 400:
					completion(.failure(.profileError(.modelError)))
				case 401:
					completion(.failure(.profileError(.unauthorized)))
				case 404:
					completion(.failure(.profileError(.photoNotFound)))
				default:
					completion(.failure(.profileError(.serverError)))
				}
			case .failure(_):
				if let requestStatusCode = response.response?.statusCode {
					switch requestStatusCode {
					case 400:
						completion(.failure(.profileError(.modelError)))
					case 401:
						completion(.failure(.profileError(.unauthorized)))
					case 404:
						completion(.failure(.profileError(.photoNotFound)))
					default:
						completion(.failure(.profileError(.serverError)))
					}
				}
			}
		}
	}

	func deleteAvatar() async throws {
		let url = baseURL + "api/profile/avatar"

		let dataResponse = await session.request(
			url,
			method: .delete,
			interceptor: interceptor
		).serializingDecodable(Empty.self).response
		let requestStatusCode = dataResponse.response?.statusCode

		switch requestStatusCode {
		case 200:
			return
		case 401:
			throw AppError.profileError(.unauthorized)
		case 404:
			throw AppError.profileError(.photoNotFound)
		default:
			throw AppError.profileError(.serverError)
		}
	}

	func logout() async throws {
		let url = baseURL + "api/auth/logout"

		let dataResponse = await session.request(
			url,
			method: .post,
			interceptor: interceptor
		).serializingDecodable(Empty.self).response
		let requestStatusCode = dataResponse.response?.statusCode

		switch requestStatusCode {
		case 401:
			throw AppError.profileError(.unauthorized)
		default:
			throw AppError.profileError(.serverError)
		}
	}
}
