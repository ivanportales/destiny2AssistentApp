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

class DataDecoderImplementation: DataDecoderProtocol {
    
    func decode<ResultType>(data: Data,
                            to type: ResultType.Type,
                            fromMime mime: String) throws -> ResultType where ResultType : Decodable {
        guard let mimeType = MimeType(rawValue: mime) else {
            throw DecoderError.unsupportedMimeType(message: "Unsupported Mime Type")
        }
        
        switch mimeType {
        case .json:
            return try JSONDecoder().decode(type, from: data)
        }
    }
}
