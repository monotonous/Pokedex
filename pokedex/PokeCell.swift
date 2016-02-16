//
//  PokeCell.swift
//  pokedex
//
//  Created by Joshua Parker on 7/02/16.
//  Copyright © 2016 Joshua Parker. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
    }
    
    func configCell(pokemon: Pokemon){
        self.pokemon = pokemon
        nameLabel.text = pokemon.pokemonName.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
