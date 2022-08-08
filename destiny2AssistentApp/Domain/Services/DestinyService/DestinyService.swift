//
//  DestinyService.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 06/08/22.
//

import Foundation

class DestinyService {
    
    let tokenResponse: TokenResponse
    let service: ServiceProtocol
    let requestFactory: RequestFactory
    
    init(tokenResponse: TokenResponse,
         service: ServiceProtocol,
         requestFactory: RequestFactory) {
        self.tokenResponse = tokenResponse
        self.service = service
        self.requestFactory = requestFactory
    }
}

extension DestinyService: HomeServiceProtocol {
    func getUserProfileInfo(completion: @escaping (Result<HomeServiceResponse, Error>) -> Void) {
        do {
            let request: Request = .getMembershipsForCurrentUser(accessToken: tokenResponse.accessToken)
            let urlRequest = try requestFactory.make(request: request)
            let expectedResultCompletion: (Result<SuccesResponse, Error>) -> Void = { result in
                switch result {
                case .success(let response):
                    completion(.success(response.response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            service.send(request: urlRequest, completion: expectedResultCompletion)
        } catch let error {
            completion(.failure(error))
        }
    }
}
