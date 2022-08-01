//
//  AuthService.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 31/07/22.
//

import Foundation

// talvez mudar isso só pra ser um cara especializado pro authservice
protocol ServiceProtocol {
    func send<ResultType: Decodable>(request: URLRequest,
                                     completion: @escaping (Result<ResultType, ServiceError>) -> Void)
}

class AuthService {
    
    private let requestFactory: RequestFactory
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol,
         requestFactory: RequestFactory) {
        self.service = service
        self.requestFactory = requestFactory
    }
    
    func send(request: AuthRequest,
              completion: @escaping (Result<String, ServiceError>) -> Void) throws {
        do {
            let request = try requestFactory.make(request: request)
            
            service.send(request: request, completion: completion)
        } catch let error {
            throw error
        }
    }
}
