//
//  APIConstantsMock.swift
//  destiny2AssistentAppTests
//
//  Created by Gonzalo Ivan Santos Portales on 04/08/22.
//

import Foundation
@testable import destiny2AssistentApp

struct APIConstantsMock: APIConstantsProtocol {
    var host: String = "www.test.net"
    var headers: [String: String] = ["X-API_Header": "apiHeader"]
}
