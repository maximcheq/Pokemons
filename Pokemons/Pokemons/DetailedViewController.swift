//
//  DetailedViewController.swift
//  Pokemons
//
//  Created by Максим  on 19.05.23.
//

import UIKit

class DetailedViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Properties
    var selectedPokemon: Pokemon?
    var detailedPokemon: DetailedPokemon?
    
    // MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedPokemon {
            nameLabel.text = selectedPokemon.name.capitalized
            fetchDetailedPokemonInfo(url: selectedPokemon.url)
        }
    }
    
    // MARK: - Methods
    private func fetchDetailedPokemonInfo(url: String) {
        NetworkManager.shared.getDetailedPokemonInfo(urlStr: url) { result in
            switch result{
            case .success(let detailedPokemon):
                self.detailedPokemon = detailedPokemon
                guard let pokemon = self.detailedPokemon else { return }
                DispatchQueue.main.async {
                    self.updateUI(with: pokemon)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.createAlert(error)
                }
            }
        }
    }
    
    private func fetchImage() {
        guard let pokemon = detailedPokemon else { return }        
        NetworkManager.shared.getPokemonImage(urlStr: pokemon.sprites.frontDefault) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.pokemonImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.createAlert(error)
                }
            }
        }
    }
    
    private func updateUI(with pokemon: DetailedPokemon) {
        var names = [String]()
        for name in pokemon.types {
            names.append(name.type.name)
        }
        
        DispatchQueue.main.async {
            self.typesLabel.text = "Types: " + names.joined(separator: ", ")
            self.heightLabel.text = "Height: \(pokemon.height * 10) cm"
            self.weightLabel.text = "Weight: \(pokemon.weight / 10) kg"
        }
        
        fetchImage()
    }
    
    // MARK: - @IBActions
    @IBAction func goBackButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
