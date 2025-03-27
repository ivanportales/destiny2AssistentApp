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
    
    private let service: ServiceProtocol
    private let configuration: AuthenticationServiceConfiguration
        
    init(service: ServiceProtocol,
         configuration: AuthenticationServiceConfiguration) {
        self.service = service
        self.configuration = configuration
    }
    
    func requestAuthentication(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            let request = configuration.makeAuthorizationRequest()
            guard let url = try service.requestFactory.make(request: request).url else {
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
            let request = configuration.makeTokenExchangeRequest(withCode: code)
            service.send(request: request, completion: completion)
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func getCodeFromUrl(url: URL) throws -> String {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw AuthenticationServiceError.tokenExchangeParamsValuesNotFound
        }
        
        guard let code = components.queryItems?.first(where: { $0.name == "code" })?.value,
              let state = components.queryItems?.first(where: { $0.name == "state" })?.value else {
                  throw AuthenticationServiceError.tokenExchangeParamsValuesNotFound
        }
        
        if configuration.state != state {
            throw AuthenticationServiceError.differentStateValue
        }
        
        return code
    }
}

extension AuthenticationService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func openWebAuthentication(withUrl url: URL, completion: @escaping (Result<Bool, Error>) -> Void) {
        let authSession = ASWebAuthenticationSession(url: url,
                                                     callbackURLScheme: configuration.appHostScheme) { [weak self] (url, error) in
                guard let url, error == nil else {
                    completion(.failure(AuthenticationServiceError.authenticationReturnedFail))
                    return
                }
                self?.requestExchangeOfCodeForBearerToken(url) { [weak self] result in
                    switch result {
                    case .success(let tokenResponse):
                        self?.service.requestFactory.append(headers: tokenResponse.toAutorizationHeader())
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
