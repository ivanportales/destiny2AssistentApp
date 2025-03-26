//
//  RequestProtocol.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 26/03/25.
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
