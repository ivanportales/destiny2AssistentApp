//
//  RequestFactory.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 24/07/22.
//

import Foundation

protocol RequestFactoryProtocol {}

struct RequestFactory: RequestFactoryProtocol {
    
    //private let APIKey = "752b9e510a124a89ab4efa4caed70457"
    private let constants: APIConstants
    
    init(constants: APIConstants) {
        self.constants = constants
    }
    
    func make(request: Request) throws -> URLRequest {
        guard let url =  makeURLComponents(from: request).url else {
            throw RequestFactoryError.errorCreatingURL
        }
        
        var urlRequest = URLRequest(url: url)
        let headers = request.headers.merging(constants.headers) { current, _ in current }
        
        for (key, value) in headers {
            urlRequest.addValue(key, forHTTPHeaderField: value)
        }

        return urlRequest
    }
    
    private func makeURLComponents(from request: Request) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.host = constants.host
        urlComponents.scheme = request.scheme
        urlComponents.path = request.path
        urlComponents.queryItems = request.queriesParameters.map { URLQueryItem(name: $0, value: $1) }
        
        return urlComponents
    }
    
//    func makeURLRequest(item: Request) -> URLRequest {
//        let url = item.buildURL()
//
//        var request = URLRequest(url: url)
//        request.addValue("X-API-Key", forHTTPHeaderField: APIKey)
//
//        for (key, value) in item.headers {
//            request.addValue(key, forHTTPHeaderField: value)
//        }
//
//        return request
//
//    }
}

enum RequestFactoryError: Error {
    case errorCreatingURL
}

protocol APIConstants {
    var host: String { get }
    var headers: [String: String] { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
}

protocol Request {
    var headers: [String: String] { get }
    var scheme: String { get }
    var path: String { get }
    var queriesParameters: [String: String] { get }
    var httpMethod: HTTPMethod { get }
}

// testar fazer implementeções do Request em enum e struct

