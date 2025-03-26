//
//  RequestFactory.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 24/07/22.
//

import Foundation

enum RequestFactoryError: Error {
    case errorCreatingURL
}

protocol RequestFactoryProtocol {
    func append(headers: [String: String])
    func make(request: RequestProtocol) throws -> URLRequest
}

final class RequestFactory: RequestFactoryProtocol {
    
    private var constants: APIConstantsProtocol
    
    init(constants: APIConstantsProtocol) {
        self.constants = constants
    }
    
    func make(request: RequestProtocol) throws -> URLRequest {
        guard let url =  makeURLComponents(from: request).url else {
            throw RequestFactoryError.errorCreatingURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.body
        
        let headers = request.headers.merging(constants.headers) { current, _ in current }
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }
    
    func append(headers: [String : String]) {
        for header in headers {
            constants.headers[header.key] = header.value
        }
    }
    
    private func makeURLComponents(from request: RequestProtocol) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.host = constants.host
        urlComponents.scheme = request.scheme.rawValue
        urlComponents.path = request.path
        urlComponents.queryItems = (request.queriesParameters.isEmpty) ? nil : request.queriesParameters.map { URLQueryItem(name: $0, value: $1) }
        
        return urlComponents
    }
}
