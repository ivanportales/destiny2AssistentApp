//
//  HomeServiceResponse.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 08/08/22.
//

import Foundation

struct SuccesResponse: Codable {
    let response: HomeServiceResponse
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }
}

struct HomeServiceResponse: Codable {
    let destinyMemberships: [DestinyMerbership]
    let user: BungieUser
    
    enum CodingKeys: String, CodingKey {
        case destinyMemberships
        case user = "bungieNetUser"
    }
}

struct DestinyMerbership: Codable {
    let displayName: String
    let iconPath: String
    let accountType: AccountType
    
    enum CodingKeys: String, CodingKey {
        case displayName
        case iconPath
        case accountType = "membershipType"
    }
}

enum AccountType: Int, Codable {
    case steam = 3
}

struct BungieUser: Codable {
    let membershipId: String
    let displayName: String
    let lastUpdate: String
    let userTitleDisplay: String
}
