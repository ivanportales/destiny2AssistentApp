//
//  AuthenticationRequest.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 02/08/22.
//

import Foundation

struct AuthorizationRequest: RequestProtocol {
    var headers: [String : String] = [:]
    var httpMethod: HTTPMethod = .get
    var scheme: HTTPScheme = .https
    var path: String = "/en/oauth/authorize"
    var queriesParameters: [String : String]
    var body: String?
    
    init(stateCallbackUniqueId: String,
         clientId: String = "40896") {
        self.queriesParameters = [
            "state": stateCallbackUniqueId,
            "response_type": "code",
            "client_id": clientId
        ]
    }
}

struct TokenExchangeRequest: RequestProtocol {
    var headers: [String : String] = ["Content-Type": "application/x-www-form-urlencoded"]
    var httpMethod: HTTPMethod = .post
    var scheme: HTTPScheme = .https
    var path: String = "/platform/app/oauth/token"
    var queriesParameters: [String : String] = [:]
    var body: String?
    
    init(code: String,
         clientId: String = "40896") {
        let bodyParameters = [
            "grant_type": "authorization_code",
            "client_id": clientId,
            "code": code 
        ]
        
        let mappedQueries = bodyParameters.map({ (key: String, value: String) in
            return "\(key)=\(value)"
        })
        
        body = mappedQueries.joined(separator: "&")
        
    }
}
