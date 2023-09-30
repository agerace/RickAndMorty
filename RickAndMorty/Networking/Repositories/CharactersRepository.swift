//
//  CharactersRepository.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import Foundation

struct CharactersListResult: Decodable {
    let results: [Character]
    let info: ResultInfo
}

struct CharacterRepository {
    
    private let characterResource = "character/"
    
    func getCharacters(page: Int) async -> Result<[Character], RMError> {
        let manager = NetworkManager()
        let resource = characterResource + "?page=\(page)"
        let request = manager.createRequest(resource: resource)
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let charactersListResult = try? JSONDecoder().decode(CharactersListResult.self, from: data) else {
                return .failure(.genericError)
            }
            return .success(charactersListResult.results)
        }
    }
    
    func getCharacters(ids: [Int]) async -> Result<[Character], RMError> {
        let manager = NetworkManager()
        
        var resource = characterResource + "["
        ids.enumerated().forEach{ (index, id) in
            resource += "\(id)"
            
            if index != ids.count - 1 {
                resource += ","
            }
        }
        resource += "]"
        
        let request = manager.createRequest(resource: resource)
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let characters = try? JSONDecoder().decode([Character].self, from: data) else {
                return .failure(.genericError)
            }
            return .success(characters)
        }
    }
    
    func getFilteredCharacters(page: Int = 1, filters: Filters) async -> Result<[Character], RMError> {
        let manager = NetworkManager()
        
        let queryString = filters.getFiltersAsQueryString() + "&page=\(page)"
        
        let resource = characterResource + queryString
        
        let request = manager.createRequest(resource: resource)
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let charactersListResult = try? JSONDecoder().decode(CharactersListResult.self, from: data) else {
                return .failure(.genericError)
            }
            return .success(charactersListResult.results)
        }
    }
}
