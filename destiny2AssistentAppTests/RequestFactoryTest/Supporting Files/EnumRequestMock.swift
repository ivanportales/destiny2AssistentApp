//
//  EnumRequestMock.swift
//  destiny2AssistentAppTests
//
//  Created by Gonzalo Ivan Santos Portales on 04/08/22.
//

import Foundation
@testable import destiny2AssistentApp

enum EnumRequestMock: RequestProtocol {
    case testingCase(id: String)
    
    var headers: [String : String] {
        switch self {
        case .testingCase:
            return [:]
        }
    }
    
    var scheme: HTTPScheme {
        switch self {
        case .testingCase:
            return .https
        }
    }
    
    var path: String {
        switch self {
        case .testingCase(let id):
            return "/path/\(id)"
        }
    }
    
    var queriesParameters: [String : String] {
        switch self {
        case .testingCase:
            return [:]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .testingCase:
            return .get
        }
    }
    
    var body: Data? {
        return nil
    }
}
