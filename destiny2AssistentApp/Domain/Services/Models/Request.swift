//
//  Request.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 29/07/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
}

enum HTTPScheme: String {
    case http = "http"
    case https = "https"
}

protocol RequestProtocol {
    var headers: [String: String] { get }
    var scheme: HTTPScheme { get }
    var path: String { get }
    var queriesParameters: [String: String] { get }
    var httpMethod: HTTPMethod { get }
}

enum Request: RequestProtocol {
    case authentication(stateCallbackUniqueId: String)
    
    var headers: [String : String] {
        switch self {
        case .authentication:
            return [:]
        }
    }
    
    var scheme: HTTPScheme {
        switch self {
        case .authentication:
            return .https
        }
    }
    
    var path: String {
        switch self {
        case .authentication:
            return ""
        }
    }
    
    var queriesParameters: [String : String] {
        switch self {
        case .authentication:
            return [:]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .authentication:
            return .get
        }
    }
}

struct AuthenticationRequest: RequestProtocol {
    var headers: [String : String] = [:]
    var scheme: HTTPScheme = .https
    var path: String = "/en/oauth/authorize"
    var queriesParameters: [String : String]
    var httpMethod: HTTPMethod = .get
    
    init(stateCallbackUniqueId: String) {
        self.queriesParameters = [
            "state": stateCallbackUniqueId,
            "response_type": "code",
            "client_id": "40896"
        ]
    }
}
