//
//  AuthenticationServiceConfiguration.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 27/03/25.
//

import Foundation

final class AuthenticationServiceConfiguration {
    
    private let authenticationRequest: AuthenticationRequestProtocol.Type
    private let tokenExchangeRequest: AuthenticationRequestProtocol.Type
    
    // MARK: This need to be safelly stored
    private let clientId = "Ov23liC2JLXWQB87FeE0"
    private let clientSecret = "a6114c1259992e389779d5cd10e869cf0a50ad87"
    
    let state = UUID().uuidString
    let appHostScheme = "destinyapp"
    
    init(authenticationRequest: AuthenticationRequestProtocol.Type,
         tokenExchangeRequest: AuthenticationRequestProtocol.Type) {
        self.authenticationRequest = authenticationRequest
        self.tokenExchangeRequest = tokenExchangeRequest
    }
    
    func makeAuthorizationRequest() -> RequestProtocol {
        authenticationRequest.init(dict: ["client_id": clientId, "state": state])
    }
    
    func makeTokenExchangeRequest(withCode code: String) -> RequestProtocol {
        tokenExchangeRequest.init(dict: ["client_id": clientId,
                                         "client_secret": clientSecret,
                                         "code": code])
    }
}
