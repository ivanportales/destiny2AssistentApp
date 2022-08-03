//
//  DecoderProtocol.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation

protocol DataDecoderProtocol {
    func decode<ResultType: Decodable>(data: Data, to type: ResultType.Type, fromMime mime: String) throws -> ResultType
}

class DataDecoder: DataDecoderProtocol {
    
    func decode<ResultType>(data: Data,
                            to type: ResultType.Type,
                            fromMime mime: String) throws -> ResultType where ResultType : Decodable {
        guard let mimeType = MimeType(rawValue: mime) else {
            throw DecoderError.unsupportedMimeType
        }
        
        do {
            switch mimeType {
            case .json:
                return try JSONDecoder().decode(type, from: data)
            }
        } catch let error as DecodingError {
            switch error {
            case .typeMismatch(let type, _):
                throw DecoderError.typeMismatch(type: type)
            case .valueNotFound(let type, _):
                throw DecoderError.valueNotFound(type: type)
            case .keyNotFound(let key, _):
                throw DecoderError.keyNotFound(key: key)
            case .dataCorrupted(_):
                throw DecoderError.corruptedData
            @unknown default:
                throw DecoderError.corruptedData
            }
        }
    }
}
