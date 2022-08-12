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
