//
//  RequestFactoryTests.swift
//  destiny2AssistentAppTests
//
//  Created by Gonzalo Ivan Santos Portales on 29/07/22.
//

import XCTest
@testable import destiny2AssistentApp

class RequestFactoryTests: XCTestCase {
    
    func testEndpoint() {
        let sut = makeSut()
        
        let request: RequestMock = .testingCase(id: "idPathParameter")
        
        do {
           let result = try sut.make(request: request)
            
            XCTAssertEqual(result.httpMethod!, HTTPMethod.get.rawValue)
            XCTAssertEqual(result.url?.relativeString, "https://www.bungie.net/Platform/User/GetBungieNetUserById/idPathParameter?")
            XCTAssertEqual(result.allHTTPHeaderFields, ["X-API-Key": "752b9e510a124a89ab4efa4caed70457"])
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func makeSut() -> RequestFactory {
        return RequestFactory(constants: Destiny2APIConstants())
    }
}

enum RequestMock: RequestProtocol {
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
            return "/Platform/User/GetBungieNetUserById/\(id)"
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
}
