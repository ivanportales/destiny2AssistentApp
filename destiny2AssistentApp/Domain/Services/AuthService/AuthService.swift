//
//  AuthService.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 31/07/22.
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


// talvez mudar isso só pra ser um cara especializado pro authservice
protocol ServiceProtocol {
    func send<ResultType: Decodable>(request: URLRequest, completion: @escaping (Result<ResultType, Error>) -> Void)
}

class AuthService {
    
    private let requestFactory: RequestFactory
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol,
         requestFactory: RequestFactory) {
        self.service = service
        self.requestFactory = requestFactory
    }
    
    func login(completion: @escaping (Result<String, Error>) -> Void) throws {
        do {
            let requestType: AuthRequest = .signIn
            let request = try requestFactory.make(request: requestType)
            
            service.send(request: request, completion: completion)
        } catch let error {
            throw error
        }
    }
}
