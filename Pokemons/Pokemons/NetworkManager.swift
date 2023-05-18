//
//  NetworkManager.swift
//  Pokemons
//
//  Created by Максим  on 18.05.23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let urlStr = "https://pokeapi.co/api/v2/pokemon"
    
    private init() {}
    
    func getPokemonsList(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
