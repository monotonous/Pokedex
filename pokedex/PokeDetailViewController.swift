//
//  PokeDetailViewController.swift
//  pokedex
//
//  Created by Joshua Parker on 7/02/16.
//  Copyright © 2016 Joshua Parker. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController {

    @IBOutlet weak var pokemonDescriptionToggle: UISegmentedControl!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonPokedexLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonDefenseLabel: UILabel!
    @IBOutlet weak var pokemonAttackLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonMovesLabel: UILabel!
    @IBOutlet weak var pokemonMovesList: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonDefense: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonAttack: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    
    @IBOutlet weak var pokemonEvolutionText: UILabel!
    @IBOutlet weak var pokemonEvolutionImageCurrent: UIImageView!
    @IBOutlet weak var pokemonEvolutionImageNext: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonNameLabel.text = pokemon.pokemonName
        let pokeImg = UIImage(named: "\(pokemon.pokedexId)")
        pokemonImage.image = pokeImg
        pokemonEvolutionImageCurrent.image = pokeImg
        pokemon.getPokemonDetails { () -> () in
            self.updateUI()
        }
    }

    func updateUI(){
        pokemonMovesLabel.hidden = true
        pokemonMovesList.hidden = true
        pokemonDescription.text = pokemon.pokemonDescription
        pokemonTypeLabel.text = pokemon.pokemonType
        pokemonDefenseLabel.text = pokemon.pokemonDefense
        pokemonAttackLabel.text = pokemon.pokemonAttack
        pokemonHeightLabel.text = pokemon.pokemonHeight
        pokemonWeightLabel.text = pokemon.pokemonWeight
        pokemonPokedexLabel.text = "\(pokemon.pokedexId)"
        if pokemon.pokemonEvolutionId == "" {
            pokemonEvolutionText.text = "No further evolution"
            pokemonEvolutionImageNext.hidden = true
        }else{
            pokemonEvolutionImageNext.hidden = false
            pokemonEvolutionImageNext.image = UIImage(named: pokemon.pokemonEvolutionId)
            var output = "Next Evolution: \(pokemon.pokemonEvolutionName)"
            if pokemon.pokemonEvolutionLevel != "" {
                output += " - Level: \(pokemon.pokemonEvolutionLevel)"
            }
            pokemonEvolutionText.text = output
        }
    }
    
    func displayBio() {
        pokemonDescription.hidden = false
        pokemonTypeLabel.hidden = false
        pokemonDefenseLabel.hidden = false
        pokemonAttackLabel.hidden = false
        pokemonHeightLabel.hidden = false
        pokemonWeightLabel.hidden = false
        pokemonHeight.hidden = false
        pokemonDefense.hidden = false
        pokemonWeight.hidden = false
        pokemonAttack.hidden = false
        pokemonType.hidden = false
        updateUI()
    }
    
    func displayMoves() {
        pokemonDescription.hidden = true
        pokemonTypeLabel.hidden = true
        pokemonDefenseLabel.hidden = true
        pokemonAttackLabel.hidden = true
        pokemonHeightLabel.hidden = true
        pokemonWeightLabel.hidden = true
        pokemonHeight.hidden = true
        pokemonDefense.hidden = true
        pokemonWeight.hidden = true
        pokemonAttack.hidden = true
        pokemonType.hidden = true
        pokemonMovesList.hidden = false
        pokemonMovesLabel.hidden = false
        pokemonMovesList.text = pokemon.pokemonMovesList
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func PokemonDetailSwitch(sender: AnyObject) {
        if pokemonDescriptionToggle.selectedSegmentIndex == 0 {
            print("BIO")
            displayBio()
        } else {
            print("MOVES")
            displayMoves()
        }
    }
}
