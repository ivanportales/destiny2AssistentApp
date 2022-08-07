//
//  DestinyService.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 06/08/22.
//

import Foundation

class DestinyService {
    
    let service: ServiceProtocol
    let requestFactory: RequestFactory
    
    init(service: ServiceProtocol,
         requestFactory: RequestFactory) {
        self.service = service
        self.requestFactory = requestFactory
    }
}

extension DestinyService: HomeServiceProtocol {
    func getUserProfileInfo(completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let request: Request = .getMembershipsForCurrentUser
            let urlRequest = try requestFactory.make(request: request)
            let expectedcompletion: (Result<String, ServiceError>) -> Void = { result in
                switch result {
                case .success(let string):
                    completion(.success(string))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            service.send(request: urlRequest, completion: expectedcompletion)
        } catch let error {
            completion(.failure(error))
        }
    }
}
