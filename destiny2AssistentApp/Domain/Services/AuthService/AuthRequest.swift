//
//  AuthRequest.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation

enum AuthRequest: RequestProtocol {
    
    case signIn
    
    var headers: [String : String] {
        switch self {
        case .signIn:
            return [:]
        }
    }
    
    var scheme: HTTPScheme {
        switch self {
        case .signIn:
            return .https
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "www.bungie.net/en/oauth/authorize"
        }
    }
    
    var queriesParameters: [String : String] {
        switch self {
        case .signIn:
            return [
                "client_id": "40896",
                "response_type": "code",
                "state": "testando"
            ]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signIn:
            return .get
        }
    }
}
