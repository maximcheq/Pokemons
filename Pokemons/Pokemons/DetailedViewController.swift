//
//  DetailedViewController.swift
//  Pokemons
//
//  Created by Максим  on 19.05.23.
//

import UIKit

class DetailedViewController: UIViewController {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var selectedPokemon: Pokemon?
    var pokemonInfoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedPokemon {
            nameLabel.text = selectedPokemon.name.capitalized
            pokemonInfoUrl = selectedPokemon.url
            typesLabel.text = pokemonInfoUrl
        
        }
    }
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
