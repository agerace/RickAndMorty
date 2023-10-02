//
//  EpisodesRepository.swift
//  RickAndMorty
//
//  Created by César Gerace on 30/09/2023.
//

import Foundation

struct EpisodesRepository {
    let manager = NetworkManager()
    private let episodeResource = "episode/"
    
    func getEpisodes(page: Int) async -> Result<[Episode], RMError> {
        let resource = episodeResource + "?page=\(page)"
        let request = manager.createRequest(resource: resource)
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let episodesListResult = try? JSONDecoder().decode(ListResult<Episode>.self, from: data) else {
                return .failure(.genericError)
            }
            return .success(episodesListResult.results)
        }
    }
    
    func getEpisodes(ids: [Int]) async -> Result<[Episode], RMError> {
        var resource = episodeResource + "["
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
            guard let episodes = try? JSONDecoder().decode([Episode].self, from: data) else {
                return .failure(.genericError)
            }
            return .success(episodes)
        }
    }
    
    func getEpisodeWith(id: Int) async -> Result<Episode, RMError> {
        let result = await self.getEpisodes(ids: [id])
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let episodes):
            guard let episode = episodes.first else {
                return .failure(.genericError)
            }
            return .success(episode)
        }
    }
    
    func getFilteredEpisodes(page: Int = 1, filters: EpisodeFilters) async -> Result<[Episode], RMError> {
        let manager = NetworkManager()
        
        let queryString = filters.getFiltersAsQueryString() + "&page=\(page)"
        
        let resource = episodeResource + queryString
        
        let request = manager.createRequest(resource: resource)
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let episodeListResult = try? JSONDecoder().decode(ListResult<Episode>.self, from: data) else {
                return .failure(.genericError)
            }
            return .success(episodeListResult.results)
        }
    }
}
