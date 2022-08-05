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
    var body: Data?
    
    init(stateCallbackUniqueId: String,
         clientId: String = "40896") {
        self.queriesParameters = [
            "state": stateCallbackUniqueId,
            "response_type": "code",
            "client_id": clientId
        ]
    }
}
