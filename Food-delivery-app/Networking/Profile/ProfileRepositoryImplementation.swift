//
//  ProfileRepositoryImplementation.swift
//  Food-delivery-app
//
//  Created by Елена on 18.06.2023.
//

import Alamofire
import UIKit

final class ProfileRepositoryImplementation: ProfileRepository {
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
			interceptor: interceptor
		).serializingDecodable(String.self)
		do {
			return try await dataTask.value
		} catch {
			let requestStatusCode = await dataTask.response.response?.statusCode

			switch requestStatusCode {
			case 200:
				throw AppError.profileError(.modelError)
			case 400:
				try await print(dataTask.value)
				throw AppError.profileError(.notCorrectOldPassword)
			case 401:
				throw AppError.profileError(.unauthorized)
			default:
				throw AppError.profileError(.serverError)
			}
		}
	}
	
	func getAvatarProfile() async throws -> UIImage {
		let url = baseURL + "api/profile/avatar"

		let dataTask = session.request(
			url,
			interceptor: interceptor
		).serializingDecodable(String.self)
		do {
			if let urlImage = URL(string: url) {
				return try await downloadImageFromURL(url: urlImage)
			}
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

		return UIImage()
	}

	func downloadImageFromURL(url: URL) async throws -> UIImage {
		return try await withCheckedThrowingContinuation { continuation in
			AF.download(url).responseData { response in
				if let data = response.value, let image = UIImage(data: data) {
					continuation.resume(returning: image)
				} else {
					continuation.resume(throwing: response.error ?? NSError(domain: "", code: 0, userInfo: nil))
				}
			}
		}
	}

	func changeAvatarProfile() async throws {

	}

	func deleteAvatarProfile() async throws {

	}
}
