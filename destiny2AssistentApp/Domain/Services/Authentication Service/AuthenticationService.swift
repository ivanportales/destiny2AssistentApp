//
//  AuthService.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 31/07/22.
//

import AuthenticationServices
import Foundation

protocol AuthenticationServiceProtocol: AnyObject {
    func requestAuthentication(completion: @escaping (Result<Bool, Error>) -> Void)
    func requestExchangeOfCodeForBearerToken(_ url: URL, completion: @escaping (Result<TokenResponse, Error>) -> Void)
}

final class AuthenticationService: NSObject, AuthenticationServiceProtocol {
    
    private let requestFactory: RequestFactoryProtocol
    private let service: ServiceProtocol
    private let state = UUID().uuidString
        
    init(service: ServiceProtocol,
         requestFactory: RequestFactoryProtocol) {
        self.service = service
        self.requestFactory = requestFactory
    }
    
    func requestAuthentication(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            guard let url = try requestFactory.make(request: GitHubAuthorizationRequest(stateCallbackUniqueId: state)).url else {
                completion(.failure(AuthenticationServiceError.urlCreationError))
                return
            }
            openWebAuthentication(withUrl: url, completion: completion)
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func requestExchangeOfCodeForBearerToken(_ url: URL, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        do {
            let code = try getCodeFromUrl(url: url)
            let request = GitHubTokenExchangeRequest(code: code)
            let urlRequest = try requestFactory.make(request: request)
            
            service.send(request: urlRequest, completion: completion)
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func getCodeFromUrl(url: URL) throws -> String {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw AuthenticationServiceError.urlCreationError
        }
        
        guard let code = components.queryItems?.first(where: { $0.name == "code" })?.value,
              let state = components.queryItems?.first(where: { $0.name == "state" })?.value else {
                  throw AuthenticationServiceError.queriesValuesNotFinded
        }
        
        if self.state != state {
            throw AuthenticationServiceError.differentStateValue
        }
        
        return code
    }
}

extension AuthenticationService: LoginServiceProtocol {
    func requestLogin(completion: @escaping (Result<Bool, Error>) -> Void) {
        requestAuthentication(completion: completion)
    }
}

extension AuthenticationService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func openWebAuthentication(withUrl url: URL, completion: @escaping (Result<Bool, Error>) -> Void) {
        let authSession = ASWebAuthenticationSession(url: url,
                                                     callbackURLScheme: "destinyapp") { [weak self] (url, error) in
                guard let url, error == nil else {
                    completion(.failure(AuthenticationServiceError.authenticationReturnedFail))
                    return
                }
                self?.requestExchangeOfCodeForBearerToken(url) { [weak self] result in
                    switch result {
                    case .success(let tokenResponse):
                        self?.requestFactory.append(headers: tokenResponse.toAutorizationHeader())
                        completion(.success(true))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        authSession.presentationContextProvider = self
        authSession.prefersEphemeralWebBrowserSession = true
        authSession.start()
    }
}
