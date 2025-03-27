//
//  AuthenticationRequest.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 02/08/22.
//

import Foundation

struct AuthorizationRequest: AuthenticationRequestProtocol {
    
    var headers: [String : String] = [:]
    var httpMethod: HTTPMethod = .get
    var scheme: HTTPScheme = .https
    var path: String = "/en/oauth/authorize"
    var queriesParameters: [String : String]
    var body: Data?
    
    init(dict: [String : String] = [:]) {
        var parameters = dict
        parameters["response_type"] = "code"
        self.queriesParameters = parameters
    }
}

struct GitHubAuthorizationRequest: AuthenticationRequestProtocol {
    var headers: [String : String] = [:]
    var httpMethod: HTTPMethod = .get
    var scheme: HTTPScheme = .https
    var path: String = "/login/oauth/authorize"
    var queriesParameters: [String : String]
    var body: Data?
    
    init(dict: [String : String] = [:]) {
        var parameters = dict
        parameters["response_type"] = "code"
        self.queriesParameters = parameters
    }
}
