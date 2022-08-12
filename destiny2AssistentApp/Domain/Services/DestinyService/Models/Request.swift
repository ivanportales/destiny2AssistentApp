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

enum Request: RequestProtocol {

    case getMembershipsForCurrentUser(accessToken: String)
    case getProfile(accessToken: String, account: DestinyAccount)
    
    var headers: [String: String] {
        switch self {
        case .getMembershipsForCurrentUser(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
        case .getProfile(let accessToken, _):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }

    var scheme: HTTPScheme {
        switch self {
        case .getMembershipsForCurrentUser,
             .getProfile:
            return .https
        }
    }

    var path: String {
        switch self {
        case .getMembershipsForCurrentUser:
            return "/Platform/User/GetMembershipsForCurrentUser/"
        case .getProfile(_, let account):
            return "/Destiny2/\(account.accountType.rawValue)/Profile/\(account.id)/"
        }
    }

    var queriesParameters: [String: String] {
        switch self {
        case .getMembershipsForCurrentUser:
            return [:]
        case .getProfile:
            return ["components": "\(ProfileComponents.characters.rawValue)"]
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getMembershipsForCurrentUser,
             .getProfile:
            return .get
        }
    }

    var body: Data? {
        switch self {
        case .getMembershipsForCurrentUser,
             .getProfile:
            return nil
        }
    }
}
