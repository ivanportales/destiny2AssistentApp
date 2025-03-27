//
//  AuthenticationRequestProtocol.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 27/03/25.
//

protocol AuthenticationRequestProtocol: RequestProtocol {
    init(dict: [String: String])
}
