//
//  AuthRepositoryImplementation.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 20.06.2023.
//

import Alamofire

final class AuthRepositoryImplementation: AuthRepository {
    
    private let baseURL = "http://94.250.248.129:10000/"
    private let interceptor = CustomRequestInterceptor()
    
    func login(credentials: LoginCredentialsModel) async throws -> TokenPairModel {
        let url = baseURL + "api/auth/login"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let dataResponse = AF.request(
            url,
            method: .post,
            parameters: credentials,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).serializingDecodable(TokenPairModel.self)
        do {
            return try await dataResponse.value
        } catch {
            let requestStatusCode = await dataResponse.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.authError(.modelError)
            case 400:
                throw AppError.authError(.invalidCredentials)
            case 500:
                throw AppError.authError(.serverError)
            default:
                throw AppError.authError(.unexpectedError)
            }
        }
    }
    
    func register(credentials: RegisterCredentialsModel) async throws -> TokenPairModel {
        let url = baseURL + "api/auth/register"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let dataResponse = AF.request(
            url,
            method: .post,
            parameters: credentials,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).serializingDecodable(TokenPairModel.self)
        do {
            return try await dataResponse.value
        } catch {
            let requestStatusCode = await dataResponse.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.authError(.modelError)
            case 400:
                throw AppError.authError(.conflictingCredentials)
            case 500:
                throw AppError.authError(.serverError)
            default:
                throw AppError.authError(.unexpectedError)
            }
        }
    }
    
    enum AuthError: LocalizedError, Identifiable {
        case unauthorized
        case invalidCredentials
        case conflictingCredentials
        case serverError
        case modelError
        case unexpectedError
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .unauthorized:
                return R.string.errors.unauthorized()
            case .invalidCredentials:
                return R.string.errors.invalid_credentials()
            case .conflictingCredentials:
                return R.string.errors.conflicting_credentials()
            case .serverError:
                return R.string.errors.server_error()
            case .modelError:
                return R.string.errors.model_error()
            case .unexpectedError:
                return R.string.errors.unexpected_error()
            }
        }
    }
    
}
