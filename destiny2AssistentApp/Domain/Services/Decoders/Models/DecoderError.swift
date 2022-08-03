//
//  DecoderError.swift
//  eveEchoesCompanionApp
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/22.
//

import Foundation

enum DecoderError: Error {
    case unsupportedMimeType
    case corruptedData
    case typeMismatch(type: Any.Type)
    case valueNotFound(type: Any.Type)
    case keyNotFound(key: CodingKey)
}

extension DecoderError: LocalizedError {
    var errorDescription: String?{
        return ErrorMessage.makeMessage(for: self)
    }
}

extension DecoderError {
    struct ErrorMessage {
        static func makeMessage(for error: DecoderError) -> String {
            switch error {
            case .unsupportedMimeType:
                return "Unsupported Mime Type"
            case .corruptedData:
                return "Corrupted Data"
            case .typeMismatch(let type):
                return "Type mismatch of: \(type)"
            case .valueNotFound(let value):
                return "Value = \(value) not found"
            case .keyNotFound(let key):
                return "Key = \(key) not found"
            }
        }
    }
}
