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
}

struct CharactersData: Codable {
    typealias CharactersDataValues = [String: DestinyCharacter]
    
    let charactersDataValues: CharactersDataValues
    
    enum CodingKeys: String, CodingKey {
        case charactersDataValues = "data"
    }
}

struct DestinyCharacter: Codable {
    let id: String
    let level: Int
    let lastPlayedDate: String
    let race: DestinyRace
    let classType: DestinyClass
    let gender: DestinyGender
    let emblemBackgroundPath: String
    let stats: DestinyEntityStats
    
    enum CodingKeys: String, CodingKey {
        case id = "characterId"
        case level = "light"
        case lastPlayedDate = "dateLastPlayed"
        case race = "raceType"
        case classType
        case gender = "genderType"
        case emblemBackgroundPath
        case stats
    }
}

enum DestinyRace: Int, Codable {
    case human = 0
    case awoken
    case exo
    case unknown
}

enum DestinyClass: Int, Codable {
    case titan = 0
    case hunter
    case warlock
    case unknown
}

enum DestinyGender: Int, Codable {
    case male = 0
    case female
    case unknown
}

struct DestinyEntityStats: Codable {
    let mobility: Int
    let resilience: Int
    let recovery: Int
    let discipline: Int
    let intellect: Int
    let strength: Int
    
    enum CodingKeys: String, CodingKey {
        case mobility = "2996146975"
        case resilience = "392767087"
        case recovery = "1943323491"
        case discipline = "1735777505"
        case intellect = "144602215"
        case strength = "4244567218"
    }
}
