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

protocol RequestProtocol {
    var headers: [String: String] { get }
    var scheme: String { get }
    var path: String { get }
    var queriesParameters: [String: String] { get }
    var httpMethod: HTTPMethod { get }
}
