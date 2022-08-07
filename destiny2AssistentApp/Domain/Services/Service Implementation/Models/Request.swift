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
    var httpMethod: HTTPMethod { get }
    var scheme: HTTPScheme { get }
    var path: String { get }
    var queriesParameters: [String: String] { get }
    var body: Data? { get }
}

// muito provavel que eu deixe tudo em struct, vamo ver
enum Request: RequestProtocol {

    case getMembershipsForCurrentUser
    
    var headers: [String: String] {
        switch self {
        case .getMembershipsForCurrentUser:
            return [:]
        }
    }

    var scheme: HTTPScheme {
        switch self {
        case .getMembershipsForCurrentUser:
            return .https
        }
    }

    var path: String {
        switch self {
        case .getMembershipsForCurrentUser:
            return "/Platform/User/GetMembershipsForCurrentUser"
        }
    }

    var queriesParameters: [String: String] {
        switch self {
        case .getMembershipsForCurrentUser:
            return [:]
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getMembershipsForCurrentUser:
            return .get
        }
    }

    var body: Data? {
        switch self {
        case .getMembershipsForCurrentUser:
            return nil
        }
    }
}
