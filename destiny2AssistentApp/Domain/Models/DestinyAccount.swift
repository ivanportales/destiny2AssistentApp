//
//  DestinyAccount.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 11/08/22.
//

import Foundation

enum AccountType: Int, Codable {
    case steam = 3
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

extension DestinyAccount: BadgeInfoModel {
    var backgroundImagePath: String? {
        return nil
    }
    
    var iconImagePath: String {
        return "/img/profile/avatars/default_avatar.gif"
    }
    
    var title: String {
        return displayName
    }
    
    var subtitle: String? {
        return "Steam"
    }
    
    var trailingInfo: String? {
        nil
    }
}
