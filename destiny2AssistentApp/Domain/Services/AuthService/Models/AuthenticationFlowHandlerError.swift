//
//  AuthenticationFlowHandlerError.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 02/08/22.
//

import Foundation

enum AuthenticationFlowHandlerError: Error, Equatable {
    case urlCreationError
    case queriesValuesNotFinded
    case differentStateValue
}

extension AuthenticationFlowHandlerError: LocalizedError {
    var errorDescription: String? {
        return ErrorMessage.makeMessage(for: self)
    }
}

extension AuthenticationFlowHandlerError {
    struct ErrorMessage {
        static func makeMessage(for error: AuthenticationFlowHandlerError) -> String {
            switch error {
            case .urlCreationError:
                return "Error Creation Error"
            case .queriesValuesNotFinded:
                return "Queries values not Finded"
            case differentStateValue:
                return "Different State Value"
            }
        }
    }
}
