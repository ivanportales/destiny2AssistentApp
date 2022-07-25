//
//  RequestFactory.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 24/07/22.
//

import Foundation

protocol RequestFactoryProtocol {}

struct RequestFactory: RequestFactoryProtocol {
    
    private let APIKey = "752b9e510a124a89ab4efa4caed70457"
    
    private func makeRequest(to url: URL,
                             withHeaders headers: [String: String]) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("X-API-Key", forHTTPHeaderField: APIKey)
        
        for (key, value) in headers {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        return request
    }
}
