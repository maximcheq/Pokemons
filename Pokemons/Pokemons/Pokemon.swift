//
//  Pokemon.swift
//  Pokemons
//
//  Created by Максим  on 18.05.23.
//

import Foundation

struct Response: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct DetailedPokemon: Codable {
    let height: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

struct TypeElement: Codable {
    let slot: Int
    let type: Types
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Types: Codable {
    let name: String
    let url: String
}
