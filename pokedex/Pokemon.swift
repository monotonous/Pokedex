//
//  Pokemon.swift
//  pokedex
//
//  Created by Joshua Parker on 3/02/16.
//  Copyright © 2016 Joshua Parker. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var name: String!
    private var pokedexID: Int!
    private var description: String!
    private var type: String!
    private var defense: String!
    private var attack: String!
    private var height: String!
    private var weight: String!
    private var evolutionText: String!
    private var nextEvolutionID: String!
    private var nextEvolutionLevel: String!
    private var pokemonURL: String!
    private var moves: String!
    
    init(name: String!, pokedexID: Int!){
        self.name = name.capitalizedString
        self.pokedexID = pokedexID
        self.pokemonURL = "\(URL)\(API)\(pokedexId)/"
    }
    
    var pokemonName: String {
        return returnValue(self.name)
    }
    
    var pokedexId: String {
        return returnValue("\(self.pokedexID)")
    }
    
    var pokemonDescription: String {
        return returnValue(self.description)
    }
    
    var pokemonType: String {
        return returnValue(self.type)
    }
    
    var pokemonDefense: String {
        return returnValue(self.defense)
    }
    
    var pokemonAttack: String {
        return returnValue(self.attack)
    }
    
    var pokemonHeight: String {
        return returnValue(self.height)
    }
    
    var pokemonWeight: String {
        return returnValue(self.weight)
    }
    
    var pokemonEvolutionName: String {
        return returnValue(self.evolutionText)
    }
    
    var pokemonEvolutionId: String {
        return returnValue(self.nextEvolutionID)
    }
    
    var pokemonEvolutionLevel: String {
        return returnValue(self.nextEvolutionLevel)
    }

    var pokemonMovesList: String {
        return returnValue(self.moves)
    }
    
    // checks if string is empty
    // returns either the string value or ""
    func returnValue(toReturn: String?) -> String {
        return (toReturn == nil ? "" : toReturn!)
    }
    
    // grabs the details of the pokemon from the api
    func getPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: pokemonURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self.weight = weight
                }
                if let height = dict["height"] as? String {
                    self.height = height
                }
                if let attack = dict["attack"] as? Int {
                    self.attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self.defense = "\(defense)"
                }

                self.type = ""
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    for var x = 0; x < types.count; x++ {
                        if let name = types[x]["name"]{
                            if x != 0 {
                                self.type! += "/"
                            }
                            self.type! += name.capitalizedString
                        }
                    }
                }

                self.description = ""
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] where descriptions.count > 0 {
                    if let url = descriptions[0]["resource_uri"] {
                        let descriptionURL = NSURL(string: "\(URL)\(url)")!
                        Alamofire.request(.GET, descriptionURL).responseJSON { response in
                            if let descriptionDict = response.result.value as? Dictionary<String,AnyObject>{
                                if let description = descriptionDict["description"] as? String {
                                    self.description = description
                                }
                            }
                            completed()
                        }
                    }
                }
                
                self.evolutionText = ""
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        if to.rangeOfString("mega") == nil { // to prevent grabbing mega evolution data
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let evoID = uri.stringByReplacingOccurrencesOfString(API, withString: "").stringByReplacingOccurrencesOfString("/", withString: "") // grab the number value from the string
                                self.nextEvolutionID = evoID
                                self.evolutionText = to
                                if let level = evolutions[0]["level"] as? Int {
                                    self.nextEvolutionLevel = "\(level)"
                                }
                            }
                        }
                    }
                }
                
                self.moves = ""
                if let movesList = dict["moves"] as? [Dictionary<String,AnyObject>] where movesList.count > 0 {
                    // for moves we are just displaying the first 12 moves that a pokemon can learn through leveling up
                    var count = 0
                    let maxCount = 12
                    for mv in movesList {
                        if count > maxCount { break }
                        
                        if let mvs = mv["learn_type"] as? String {
                            if mvs.rangeOfString("level up") != nil {
                                if let mvName = mv["name"] as? String {
                                    self.moves.appendContentsOf("\(mvName)\n")
                                    count += 1
                                }
                            }
                        }
                    }
                    
                    for ; count < maxCount; count++ { self.moves.appendContentsOf("\n") }
                }
            }
            completed()
        }
    }
}