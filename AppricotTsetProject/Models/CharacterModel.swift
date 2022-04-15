//
//  CharacterModel.swift
//  AppricotTsetProject
//
//  Created by Roman Efimov on 14.04.2022.
//

import Foundation

struct CharacterModel: Decodable{
    let info: Info
    let results: [CharacterResults]
}


struct Info: Decodable{
    let pages: Int
}


struct CharacterResults: Decodable{
    let id: Int
    let name: String
    let species: String
    let gender: String
    let image: String    
}
