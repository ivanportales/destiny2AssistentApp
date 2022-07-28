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
    private let constants: APIConstants
    
    init(constants: APIConstants) {
        self.constants = constants
    }
    
    func makeURLRequest(item: URLItem) -> URLRequest {
        let url = item.buildURL()
        
        var request = URLRequest(url: url)
        request.addValue("X-API-Key", forHTTPHeaderField: APIKey)
        
        for (key, value) in item.headers {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        return request
        
    }
}

protocol APIConstants {
    var host: String { get }
    var scheme: String { get }
    var apiKey: String { get }
}

protocol URLItem {
    var headers: [String: String] { get }
    
    func buildURL() -> URL
}
