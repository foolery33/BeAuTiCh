//
//  CustomRequestInterceptor.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 12.06.2023.
//

import Foundation

import Alamofire

class CustomRequestInterceptor: RequestInterceptor {
    
    private let retryLimit = 2
    private let retryDelay: TimeInterval = 1
    
    private let tokenManagerRepository: TokenManagerRepository = TokenManagerRepositoryImplementation()
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if tokenManagerRepository.fetchAccessToken() != nil {
            urlRequest.setValue("Bearer \(tokenManagerRepository.fetchAccessToken()!)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = (request.task?.response as? HTTPURLResponse)?.statusCode else {
            completion(.doNotRetry)
            return
        }
        switch statusCode {
        case 401:
            refreshToken { [weak self] in
                guard let self,
                  request.retryCount < self.retryLimit else {
                // Если уже попытались повторить запрос максимальное количество раз, то прекращаем попытки
                completion(.doNotRetry)
                return
            }
                completion(.retryWithDelay(self.retryDelay))
            }
        case (501...599):
            guard request.retryCount < retryLimit else { return }
            completion(.retryWithDelay(retryDelay))
        default:
            completion(.doNotRetry)
        }
    }
    
    private func refreshToken(completion: @escaping (() -> Void)) {
        let body = [
            "accessToken": tokenManagerRepository.fetchAccessToken(),
            "refreshToken": tokenManagerRepository.fetchRefreshToken()
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let url = "http://94.250.248.129:10000/api/auth/refresh"
        AF.request(url, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).responseData { response in
            if let statusCode = response.response?.statusCode {
                print("Refresh Status Code:", statusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(TokenPairModel.self, from: data)
                    self.tokenManagerRepository.setAccessToken(decodedData.accessToken)
                    self.tokenManagerRepository.setRefreshToken(decodedData.refreshToken)
                    completion()
                } catch {
                    completion()
                    return
                }
            case .failure(_):
                completion()
                return
            }
        }
    }
}
