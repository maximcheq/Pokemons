//
//  ViewController.swift
//  Pokemons
//
//  Created by Максим  on 18.05.23.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        return tableView
    }()
    
    private var pokemons = [Pokemon]()
    private var nextPokemonsUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemons"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        fetchNextPokemonsUrl(with: NetworkManager.urlStr)
        fetchPokemons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchPokemons() {
        NetworkManager.shared.getPokemonsList(urlStr: NetworkManager.urlStr) { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchNextPokemonsUrl(with url: String) {
        NetworkManager.shared.getNewPokemonsUrl(urlStr: url) { result in
            switch result {
            case .success(let urlStr):
                self.nextPokemonsUrl = urlStr
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchNextPokemons() {
        NetworkManager.shared.getPokemonsList(urlStr: nextPokemonsUrl) { result in
            switch result {
            case .success(let pokemons):
                self.pokemons.append(contentsOf: pokemons)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1) \(pokemon.name.capitalized)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 {
            fetchNextPokemons()
            fetchNextPokemonsUrl(with: nextPokemonsUrl)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailedViewController") as? DetailedViewController else { return }
        let pokemon = pokemons[indexPath.row]
        vc.selectedPokemon = pokemon
        
        navigationController?.present(vc, animated: true)
    }
}

