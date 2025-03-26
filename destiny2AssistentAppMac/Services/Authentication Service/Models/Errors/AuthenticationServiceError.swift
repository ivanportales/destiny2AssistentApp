//
//  AuthenticationFlowHandlerError.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 02/08/22.
//

import Foundation

enum AuthenticationServiceError: Error {
    case urlCreationError
    case queriesValuesNotFound
    case differentStateValue
    case authenticationReturnedFail
}

extension AuthenticationServiceError: LocalizedError {
    var errorDescription: String? {
        return ErrorMessage.makeMessage(for: self)
    }
}

extension AuthenticationServiceError {
    struct ErrorMessage {
        static func makeMessage(for error: AuthenticationServiceError) -> String {
            switch error {
            case .urlCreationError:
                return "URL Creation Error"
            case .queriesValuesNotFound:
                return "Queries values for Token Exchange not found"
            case differentStateValue:
                return "Different State value of authentication and token exchange parameter"
            case .authenticationReturnedFail:
                return "Authentication response from Web returned error"
            }
        }
    }
}
