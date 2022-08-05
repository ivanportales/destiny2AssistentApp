//
//  TokenResponse.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 03/08/22.
//

import Foundation

struct TokenResponse: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String?
    let refreshExpiresIn: Int?
    let membershipId: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshExpiresIn = "refresh_expires_in"
        case membershipId = "membership_id"
    }
}
