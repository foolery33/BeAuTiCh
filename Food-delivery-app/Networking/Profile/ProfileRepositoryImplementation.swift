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

	func changeDataProfile(parameters: ChangeDataProfileModel) async throws {
		let url = baseURL + "api/profile"

		session.request(
			url,
			method: .patch,
			parameters: parameters,
			encoder: JSONParameterEncoder.default,
			interceptor: interceptor
		).responseData { response in
			Task {
				do {
					let statusCode = response.response?.statusCode

					switch statusCode {
					case 200:
						print(response.value ?? "Success")
					case 400:
						throw AppError.profileError(.modelError)
					case 401:
						throw AppError.profileError(.unauthorized)
					default:
						throw AppError.profileError(.serverError)
					}
				}
			}
		}
	}
	
	func getAvatarProfile() async throws -> UIImageView {
		return await UIImageView()
	}

	func changeAvatarProfile() async throws {

	}

	func deleteAvatarProfile() async throws {

	}
}
