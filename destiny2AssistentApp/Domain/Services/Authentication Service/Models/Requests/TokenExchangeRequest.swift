//
//  TokenExchangeRequest.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 03/08/22.
//

import Foundation

struct TokenExchangeRequest: RequestProtocol {
    var headers: [String : String] = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    var httpMethod: HTTPMethod = .post
    var scheme: HTTPScheme = .https
    var path: String = "/platform/app/oauth/token"
    var queriesParameters: [String : String] = [:]
    var bodyParameters: [String: String]
    var body: Data? {
        let mappedQueries = bodyParameters.map({ (key: String, value: String) in
            return "\(key)=\(value)"
        })
        
        let parameters = mappedQueries.joined(separator: "&")
        
        return parameters.data(using: .utf8)
    }
    
    init(code: String,
         clientId: String = "40896") {
        bodyParameters = [
            "grant_type": "authorization_code",
            "client_id": clientId,
            "client_secret": "Pd3fC4HqzUlLcxL1W2qr22TKTmeMwUmaVewXLCVgRMU",
            "code": code
        ]
    }
}
