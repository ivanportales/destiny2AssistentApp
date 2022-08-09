//
//  HomeServiceResponse.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 08/08/22.
//

import Foundation

struct SuccesResponse: Codable {
    let response: HomeModel
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }
}

struct HomeModel: Codable {
    let destinyAccounts: [DestinyAccount]
    let user: BungieUser
    
    enum CodingKeys: String, CodingKey {
        case destinyAccounts = "destinyMemberships"
        case user = "bungieNetUser"
    }
    
    static let emptyModel: HomeModel = .init(destinyAccounts: [],
                                             user: .init(membershipId: "",
                                                         displayName: "Empty Name",
                                                         lastUpdate: "",
                                                         userTitleDisplay: ""))
}

struct DestinyAccount: Codable {
    let id: String
    let displayName: String
    let iconPath: String
    let accountType: AccountType
    
    enum CodingKeys: String, CodingKey {
        case id = "membershipId"
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
