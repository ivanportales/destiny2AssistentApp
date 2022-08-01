//
//  DecoderError.swift
//  eveEchoesCompanionApp
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/22.
//

import Foundation

enum DecoderError: Error {
    case unsupportedMimeType(message: String)
    case corruptedData(message: String)
}

extension DecoderError: LocalizedError {
    var errorDescription: String?{
        switch self {
        case .unsupportedMimeType(message: let message):
            return message
        case .corruptedData(message: let message):
            return message
        }
    }
}
