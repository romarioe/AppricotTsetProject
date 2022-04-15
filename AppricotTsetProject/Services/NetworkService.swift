//
//  NetworkService.swift
//  AppricotTsetProject
//
//  Created by Roman Efimov on 14.04.2022.
//

import Foundation


class NetworkService {
    
    
    private func prepareURL(params: [String: String]) -> URL {
        var charactersURL = URLComponents()
        charactersURL.scheme = "https"
        charactersURL.host = "rickandmortyapi.com"
        charactersURL.path = "/api/character"
        charactersURL.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return charactersURL.url!
    }
    
    
    
    private func prepareParaments(page: Int) -> [String: String] {
        var parameters = [String: String]()
        parameters["page"] = String(page)
        return parameters
    }
    
    
    
    private func prepareDetailURL(id: Int) -> URL {
        var characterDetailURL = URLComponents()
        characterDetailURL.scheme = "https"
        characterDetailURL.host = "rickandmortyapi.com"
        characterDetailURL.path = "/api/character" + "/" + String(id)
        return characterDetailURL.url!
    }
    
    
    
    func fetchCharacters(page: Int, completion: @escaping (CharacterModel?) -> Void){
        let parametrs = prepareParaments(page: page)
        let charactersURL = prepareURL(params: parametrs)
        let task = URLSession.shared.dataTask(with: charactersURL) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDecoder = JSONDecoder()
            
            let characters = try? jsonDecoder.decode(CharacterModel.self, from: data)
            completion (characters)
            
        }
        task.resume()
    }
    
    
    
    
    func fetchDetailCharacter(id: Int, completion: @escaping (DetailCharacterModel?) -> Void){
        
        let characterDetailURL = prepareDetailURL(id: id)
        let task = URLSession.shared.dataTask(with: characterDetailURL) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDecoder = JSONDecoder()
            
            let characterDetail = try? jsonDecoder.decode(DetailCharacterModel.self, from: data)
            completion (characterDetail)
            
        }
        task.resume()
    }
    
       
    
}
