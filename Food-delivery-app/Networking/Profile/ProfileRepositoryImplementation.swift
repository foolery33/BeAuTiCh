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
				throw AppError.profileError(.serverError)
			}
		}
	}
	
	func changeAvatar(imageData: Data) async throws -> String {
		let url = baseURL + "api/profile/avatar"
		
		let dataTask = session.upload(multipartFormData: { multipartFormData in
			multipartFormData.append(imageData, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
			
		}, to: url, method: .post, interceptor: interceptor).serializingString()
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

	func uploadPhoto(imageData: Data, completion: @escaping (Result<Bool, AppError>) -> Void) {
		let url = baseURL + "api/profile/avatar"
		let headers: HTTPHeaders = [
			"Authorization": "Bearer \(TokenManagerRepositoryImplementation().fetchAccessToken()!)",
			"Content-type": "multipart/form-data"
				]

		print(headers)

		session.upload(multipartFormData: { multipartFormData in
			multipartFormData.append(imageData, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
		}, to: url, headers: headers).validate().responseData { response in
			switch response.result {
			case .success:
				completion(.success(true))
			case .failure(let error):
				if let requestStatusCode = response.response?.statusCode {
					switch requestStatusCode {
					case 400:
						completion(.failure(.profileError(.modelError)))
					case 401:
						completion(.failure(.profileError(.unauthorized)))
					default:
						completion(.failure(.profileError(.serverError)))
					}
				}

				if let error = error as? AFError {
							switch error {
							case .createUploadableFailed(let error):
								debugPrint("Create Uploadable Failed, description: \(error.localizedDescription)")
							case .createURLRequestFailed(let error):
								debugPrint("Create URL Request Failed, description: \(error.localizedDescription)")
							case .downloadedFileMoveFailed(let error, let source, let destination):
								debugPrint("Downloaded File Move Failed, description: \(error.localizedDescription)")
								debugPrint("Source: \(source), Destination: \(destination)")
							case .explicitlyCancelled:
								debugPrint("Explicitly Cancelled - \(error.localizedDescription)")
							case .invalidURL(let url):
								debugPrint("Invalid URL: \(url) - \(error.localizedDescription)")
							case .multipartEncodingFailed(let reason):
								debugPrint("Multipart encoding failed, description: \(error.localizedDescription)")
								debugPrint("Failure Reason: \(reason)")
							case .parameterEncodingFailed(let reason):
								debugPrint("Parameter encoding failed, description: \(error.localizedDescription)")
								debugPrint("Failure Reason: \(reason)")
							case .parameterEncoderFailed(let reason):
								debugPrint("Parameter Encoder Failed, description: \(error.localizedDescription)")
								debugPrint("Failure Reason: \(reason)")
							case .requestAdaptationFailed(let error):
								debugPrint("Request Adaptation Failed, description: \(error.localizedDescription)")
							case .requestRetryFailed(let retryError, let originalError):
								debugPrint("Request Retry Failed")
								debugPrint("Original error description: \(originalError.localizedDescription)")
								debugPrint("Retry error description: \(retryError.localizedDescription)")
							case .responseValidationFailed(let reason):
								debugPrint("Response validation failed, description: \(error.localizedDescription)")
								switch reason {
								case .dataFileNil, .dataFileReadFailed:
									debugPrint("Downloaded file could not be read")
								case .missingContentType(let acceptableContentTypes):
									debugPrint("Content Type Missing: \(acceptableContentTypes)")
								case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
									debugPrint("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
								case .unacceptableStatusCode(let code):
									debugPrint("Response status code was unacceptable: \(code)")
								default: break
								}
							case .responseSerializationFailed(let reason):
								debugPrint("Response serialization failed: \(error.localizedDescription)")
								debugPrint("Failure Reason: \(reason)")
							case .serverTrustEvaluationFailed(let reason):
								debugPrint("Server Trust Evaluation Failed, description: \(error.localizedDescription)")
								debugPrint("Failure Reason: \(reason)")
							case .sessionDeinitialized:
								debugPrint("Session Deinitialized, description: \(error.localizedDescription)")
							case .sessionInvalidated(let error):
								debugPrint("Session Invalidated, description: \(error?.localizedDescription ?? "")")
							case .sessionTaskFailed(let error):
								debugPrint("Session Task Failed, description: \(error.localizedDescription)")
							case .urlRequestValidationFailed(let reason):
								debugPrint("Url Request Validation Failed, description: \(error.localizedDescription)")
								debugPrint("Failure Reason: \(reason)")
							}
						}
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
