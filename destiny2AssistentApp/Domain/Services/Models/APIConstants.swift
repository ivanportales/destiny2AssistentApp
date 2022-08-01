//
//  RequestFactoryImplementation.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 29/07/22.
//

import Foundation

protocol APIConstantsProtocol {
    var host: String { get }
    var headers: [String: String] { get }
}

struct Destiny2APIConstants: APIConstantsProtocol {
    let host: String = "www.bungie.net"
    //let host: String = "www.bungie.net/Platform"

    let headers: [String : String] = [
        "X-API-Key": "752b9e510a124a89ab4efa4caed70457"
    ]
    
    init() {}
}

struct AuthenticationConstants: APIConstantsProtocol {
    let host: String = "www.bungie.net"
    let headers: [String : String] = [:]
    
    init() {}
}
