//
//  AuthService.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 31/07/22.
//

import Foundation

protocol AuthenticationFlowHandler {
    func handleURLFromDeepLink(_ url: URL, completion: @escaping (Result<Void, Error>) -> Void)
}

class AuthService {
    
    private let requestFactory: RequestFactory
    private let service: ServiceProtocol
    private let state = UUID().uuidString
    
    private var loginRequestCallback: ((Result<Void, Error>) -> Void)?
    var requestedAuthorizationCallback: ((URL) -> Void)?
    
    init(service: ServiceProtocol,
         requestFactory: RequestFactory) {
        self.service = service
        self.requestFactory = requestFactory
    }
    
    func requestAuthorization(completion: @escaping (Result<String, ServiceError>) -> Void) throws {
        do {
            let authRequest = AuthorizationRequest(stateCallbackUniqueId: state)
            let request = try requestFactory.make(request: authRequest)
            
            service.send(request: request, completion: completion)
        } catch let error {
            throw error
        }
    }
    
    func requestLogin(completion: @escaping (Result<Void, Error>) -> Void) {
        loginRequestCallback = completion
        
        do {
            guard let url = try requestFactory.make(request: AuthorizationRequest(stateCallbackUniqueId: state)).url else {
                return
            }
            requestedAuthorizationCallback?(url)
        } catch let error {
            loginRequestCallback = nil
            completion(.failure(error))
        }
    }
}

struct TokenResponse: Decodable {
    let accessToken: String
    let tokenType: String?
    let expiresIn: Int?
    let refreshToken: String?
    let refreshExpiresIn: Int?
    let membershipId: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshExpiresIn = "refresh_expires_in"
        case membershipId = "membership_id"
    }
}

extension AuthService: AuthenticationFlowHandler {
    func handleURLFromDeepLink(_ url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let code = try getCodeFromUrl(url: url)
            let request = TokenExchangeRequest(code: code)
            let urlRequest = try requestFactory.make(request: request)
            let serviceCompletion: (Result<TokenResponse, ServiceError>) -> Void = { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
            service.send(request: urlRequest, completion: serviceCompletion)
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getCodeFromUrl(url: URL) throws -> String {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw AuthenticationFlowHandlerError.urlCreationError
        }
        
        guard let code = components.queryItems?.first(where: { $0.name == "code" })?.value,
              let state = components.queryItems?.first(where: { $0.name == "state" })?.value else {
                  throw AuthenticationFlowHandlerError.queriesValuesNotFinded
        }
        
        if self.state != state {
            throw AuthenticationFlowHandlerError.differentStateValue
        }
        
        return code
    }
}
