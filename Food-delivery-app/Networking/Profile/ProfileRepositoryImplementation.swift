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
		interceptor = CustomRequestInterceptor(tokenManagerRepository: tokenManagerRepository)
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
		let dataTask = session.request(
			url,
			interceptor: interceptor
		).serializingDecodable(ProfileModel.self)
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			
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
	
	func changeDataProfile(parameters: ChangeDataProfileModel) async throws -> String {
		let url = baseURL + "api/profile"
		let dataTask = session.request(
			url,
			method: .patch,
			parameters: parameters,
			interceptor: interceptor
		).serializingDecodable(String.self)
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			
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
	
	func changePassword(parameters: ChangePassword) async throws -> String {
		let url = baseURL + "api/profile/password"
		
		let dataTask = session.request(
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
				throw AppError.profileError(.modelError)
			case 400:
				throw AppError.profileError(.notCorrectOldPassword)
			case 401:
				throw AppError.profileError(.unauthorized)
			default:
				throw AppError.profileError(.serverError)
			}
		}
	}
	
	func getAvatar() async throws -> Data {
		let url = baseURL + "api/profile/avatar"
		let dataTask = AF.request(
			url,
			method: .post,
			interceptor: interceptor).serializingData()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
			switch requestStatusCode {
			case 400:
				throw AppError.profileError(.modelError)
			case 401:
				throw AppError.profileError(.unauthorized)
			case 404:
				throw AppError.profileError(.photoNotFound)
			default:
				throw AppError.profileError(.modelError)
			}
		}
	}
	
	func changeAvatar(imageData: Data) async throws -> String {
		let url = baseURL + "api/profile/avatar"
		
		let dataTask = session.upload(multipartFormData: { multipartFormData in
			multipartFormData.append(imageData, withName: "fileset", fileName: "file.png", mimeType: "image/png")
			
		}, to: url,interceptor: interceptor).serializingString()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode
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

	func deleteAvatar() async throws -> String {
		let url = baseURL + "api/profile/avatar"

		let dataTask = session.request(
			url,
			method: .delete,
			interceptor: interceptor
		).serializingString()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode

			switch requestStatusCode {
			case 200:
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

	func logout() async throws -> String {
		let url = baseURL + "api/auth/logout"

		let dataTask = session.request(
			url,
			method: .post,
			interceptor: interceptor
		).serializingString()
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode

			switch requestStatusCode {
			case 401:
				throw AppError.profileError(.unauthorized)
			default:
				throw AppError.profileError(.serverError)
			}
		}
	}
}
