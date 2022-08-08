//
//  ServiceImplementation.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation

protocol ServiceProtocol {
    func send<ResultType: Decodable>(request: URLRequest,
                                     completion: @escaping (Result<ResultType, Error>) -> Void)
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
                                     completion: @escaping (Result<ResultType, Error>) -> Void) {
        httpClient.makeRequest(to: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(ServiceError.serverError(message: error.localizedDescription).asError))
                return
            }
            
            guard let httpResponse = response else {
                completion(.failure(ServiceError.noServerResponseError.asError))
                return
            }
    
            if !(200..<299).contains(httpResponse.statusCode) {
                completion(.failure(ServiceError.httpStatusCodeError(statusCode: httpResponse.statusCode).asError))
                return
            }
            
            guard let mimeType = httpResponse.mimeType else {
                completion(.failure(ServiceError.noHTTPMimeTypeInformed.asError))
                return
            }
            
            guard let data = data else {
                completion(.failure(ServiceError.corruptedDataError.asError))
                return
            }

            do {
                guard let decodedData = try self?.decoder.decode(data: data, to: ResultType.self, fromMime: mimeType) else {
                    completion(.failure(ServiceError.serializationError(message: "Corrupted Decoder").asError))
                    return
                }
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(ServiceError.serializationError(message: "Serialization Error: \(error.localizedDescription)").asError))
            }
        }
    }
}
