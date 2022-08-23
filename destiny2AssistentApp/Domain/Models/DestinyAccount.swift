//
//  DestinyAccount.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 11/08/22.
//

import Foundation

enum AccountType: Int, Codable {
    case steam = 3
    
    var typeString: String {
        switch self {
        case .steam:
            return "Steam"
        }
    }
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
        return iconPath
    }
    
    var title: String {
        return displayName
    }
    
    var subtitle: String? {
        return accountType.typeString
    }
    
    var trailingInfo: String? {
        nil
    }
}
