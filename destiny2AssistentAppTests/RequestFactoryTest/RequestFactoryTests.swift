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
        
        let request: StructRequestMock = .init(id: "idPathParameter")
        
        do {
           let result = try sut.make(request: request)
            
            XCTAssertEqual(result.httpMethod!, HTTPMethod.get.rawValue)
            XCTAssertEqual(result.url?.relativeString, "https://www.test.net/path/idPathParameter?")
            XCTAssertEqual(result.allHTTPHeaderFields, ["X-API_Header": "apiHeader"])
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func makeSut() -> RequestFactory {
        return RequestFactory(constants: APIConstantsMock())
    }
}

