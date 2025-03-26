//
//  HTTPResponseProtocol.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation

protocol HTTPResponseProtocol {
    var mimeType: String? { get }
    var statusCode: Int { get }
}

extension HTTPURLResponse: HTTPResponseProtocol {}
