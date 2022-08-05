//
//  ServiceImplementation.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation

protocol ServiceProtocol {
    func send<ResultType: Decodable>(request: URLRequest,
                                     completion: @escaping (Result<ResultType, ServiceError>) -> Void)
}

class Service: ServiceProtocol {
    
    private let httpClient: HTTPClientProtocol
    private let decoder: DataDecoderProtocol
    
    init(httpClient: HTTPClientProtocol = URLSession.shared,
         decoder: DataDecoderProtocol = DataDecoder()) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    func send<ResultType: Decodable>(request: URLRequest,
                                     completion: @escaping (Result<ResultType, ServiceError>) -> Void) {
        httpClient.makeRequest(to: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(.serverError(message: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response else {
                completion(.failure(.noServerResponseError))
                return
            }
    
            if !(200..<299).contains(httpResponse.statusCode) {
                completion(.failure(.httpStatusCodeError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let mimeType = httpResponse.mimeType else {
                completion(.failure(.noHTTPMimeTypeInformed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.corruptedDataError))
                return
            }

            do {
                guard let decodedData = try self?.decoder.decode(data: data, to: ResultType.self, fromMime: mimeType) else {
                    completion(.failure(.serializationError(message: "Corrupted Decoder")))
                    return
                }
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(.serializationError(message: "Serialization Error: \(error.localizedDescription)")))
            }
        }
    }
}
