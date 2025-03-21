//
//  ServiceError.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation

enum ServiceError: Error, Equatable {
    case serverError(message: String)
    case noServerResponseError
    case httpStatusCodeError(statusCode: Int)
    case noHTTPMimeTypeInformed
    case corruptedDataError
    case serializationError(message: String)
    
    var asError: Error {
        return self as Error
    }
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        return ErrorMessage.makeMessage(for: self)
    }
}

extension ServiceError {
    struct ErrorMessage {
        static func makeMessage(for error: ServiceError) -> String {
            switch error {
            case .serverError(let message):
                return "Server error: \(message)"
            case .noServerResponseError:
                return "No Server Response"
            case .httpStatusCodeError(let statusCode):
                return "HTTP Status Error: \(statusCode)"
            case .noHTTPMimeTypeInformed:
                return "No MIME type informed"
            case .corruptedDataError:
                return "Corrupted Data Error"
            case .serializationError(let message):
                return "Serialization Error: \(message)"
            }
        }
    }
}
