//
//  File.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 11/08/22.
//

import Foundation

struct GetProfileResponse: Codable {
    let response: Characters
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }
}

struct Characters: Codable {
    let characters: CharactersData
    
    enum CodingKeys: String, CodingKey {
        case characters
    }
}

typealias CharactersDataValues = [String: DestinyCharacter]

struct CharactersData: Codable {
    let charactersDataValues: CharactersDataValues
    
    enum CodingKeys: String, CodingKey {
        case charactersDataValues = "data"
    }
}

struct DestinyCharacter: Codable {
    let id: String
    let lastPlayedDate: String
    let raceType: DestinyRaceType
    let classType: DestinyClassType
    let genderType: DestinyGenderType
    let emblemBackgroundPath: String
    let stats: CharacterStats

    enum CodingKeys: String, CodingKey {
        case id = "characterId"
        case lastPlayedDate = "dateLastPlayed"
        case raceType
        case classType
        case genderType
        case emblemBackgroundPath
        case stats
    }
}

enum DestinyRaceType: Int, Codable {
    case human = 0
    case awoken
    case exo
    case unknown
}

enum DestinyClassType: Int, Codable {
    case titan = 0
    case hunter
    case warlock
    case unknown
}

enum DestinyGenderType: Int, Codable {
    case male = 0
    case female
    case unknown
}

enum DestinyCharacterStat: String, Codable {
    case mobility = "2996146975"
    case resilience = "392767087"
    case recovery = "1943323491"
    case discipline = "1735777505"
}

typealias CharacterStats = [String: Int]
