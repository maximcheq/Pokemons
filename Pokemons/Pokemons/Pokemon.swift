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
