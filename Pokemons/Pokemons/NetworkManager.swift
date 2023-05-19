//
//  NetworkManager.swift
//  Pokemons
//
//  Created by Максим  on 18.05.23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    static let urlStr = "https://pokeapi.co/api/v2/pokemon"
    
    private init() {}
    
    func getPokemonsList(urlStr: String, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
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
    
    func getDetailedPokemonInfo(urlStr: String, completion: @escaping (Result<DetailedPokemon, Error>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(DetailedPokemon.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getNewPokemonsUrl(urlStr: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.next))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getPokemonImage(urlStr: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
