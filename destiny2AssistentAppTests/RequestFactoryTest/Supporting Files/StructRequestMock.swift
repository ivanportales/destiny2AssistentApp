//
//  StructRequestMock.swift
//  destiny2AssistentAppTests
//
//  Created by Gonzalo Ivan Santos Portales on 04/08/22.
//

import Foundation
@testable import destiny2AssistentApp

struct StructRequestMock: RequestProtocol {
    var headers: [String: String] = [:]
    var httpMethod: HTTPMethod = .get
    var scheme: HTTPScheme = .https
    var path: String
    var queriesParameters: [String: String] = [:]
    var body: Data?
    
    init(id: String) {
        self.path = "/path/\(id)"
    }
}
