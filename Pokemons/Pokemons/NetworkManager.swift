//
//  NetworkManager.swift
//  Pokemons
//
//  Created by Максим  on 18.05.23.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    static let urlStr = "https://pokeapi.co/api/v2/pokemon"
        
    private init() {}
    
    func getPokemonsList(urlStr: String, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        if let savedResponse = UserDefaults.standard.object(forKey: urlStr) as? Data {
            let decoder = JSONDecoder()
            if let loadedResponse = try? decoder.decode(Response.self, from: savedResponse) {
                completion(.success(loadedResponse.results))
                print("from storage")
                return
            }
        }
        
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(result) {
                        UserDefaults.standard.set(encoded, forKey: urlStr)
                    }
                    print("from internet")
                    completion(.success(result.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getDetailedPokemonInfo(urlStr: String, completion: @escaping (Result<DetailedPokemon, Error>) -> Void) {
        if let savedResponse = UserDefaults.standard.object(forKey: urlStr) as? Data {
            let decoder = JSONDecoder()
            if let loadedResponse = try? decoder.decode(DetailedPokemon.self, from: savedResponse) {
                completion(.success(loadedResponse))
                print("from storage")
                return
            }
        }
        
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(DetailedPokemon.self, from: data)
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(result) {
                        UserDefaults.standard.set(encoded, forKey: urlStr)
                    }
                    print("from internet")
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getNewPokemonsUrl(urlStr: String, completion: @escaping (Result<String, Error>) -> Void) {
        if let savedResponse = UserDefaults.standard.object(forKey: urlStr) as? Data {
            let decoder = JSONDecoder()
            if let loadedResponse = try? decoder.decode(Response.self, from: savedResponse) {
                completion(.success(loadedResponse.next))
                print("from storage")
                return
            }
        }
        
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(result) {
                        UserDefaults.standard.set(encoded, forKey: urlStr)
                    }
                    print("from internet")
                    completion(.success(result.next))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    

    func getPokemonImage(urlStr: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let savedResponse = UserDefaults.standard.object(forKey: urlStr) as? Data {
            let decoder = JSONDecoder()
            if let loadedResponse = try? decoder.decode(Data.self, from: savedResponse) {
                completion(.success(loadedResponse))
                print("image from storage")
                return
            }
        }
        
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(data) {
                    UserDefaults.standard.set(encoded, forKey: urlStr)
                }
                print("image from internet")
                completion(.success(data))
            }
        }.resume()
    }
}
