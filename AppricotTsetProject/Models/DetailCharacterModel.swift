//
//  DetailCharacterModel.swift
//  AppricotTsetProject
//
//  Created by Roman Efimov on 14.04.2022.
//

import Foundation


struct DetailCharacterModel: Decodable{
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: String
    let episode: [String]
}


struct Location: Decodable{
    let name: String
}

