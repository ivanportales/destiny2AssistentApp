//
//  Request.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 29/07/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
}

enum HTTPScheme: String {
    case http = "http"
    case https = "https"
}

protocol RequestProtocol {
    var headers: [String: String] { get }
    var scheme: HTTPScheme { get }
    var path: String { get }
    var queriesParameters: [String: String] { get }
    var httpMethod: HTTPMethod { get }
}

enum Request: RequestProtocol {
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
            return "/User/GetBungieNetUserById/\(id)"
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
