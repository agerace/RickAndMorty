//
//  EpisodeFilters.swift
//  RickAndMorty
//
//  Created by César Gerace on 02/10/2023.
//

import Foundation

struct EpisodeFilters {
    var name: String = ""
    var seasonCode: SeasonCode = .allSeasons
    var episodeCode: EpisodeCode = .allEpisodes
    
    func getFiltersAsQueryString() -> String {
        var queryFilters = [String]()
        
        if self.name != "" {
            queryFilters.append("name=\(name)")
        }
        if seasonCode != .allSeasons {
            if episodeCode != .allEpisodes {
                queryFilters.append("episode=\(seasonCode.rawValue)\(episodeCode.rawValue)")
            }
            queryFilters.append("episode=\(seasonCode.rawValue)")
        }else if episodeCode != .allEpisodes {
            queryFilters.append("episode=\(episodeCode.rawValue)")
        }
        
        var queryString = "?"
        
        queryFilters.enumerated().forEach{ (index, filter) in
            if index != 0 {
                queryString += "&"
            }
            queryString += filter
        }
        return queryString
    }
    
}

extension EpisodeFilters: Equatable {
    static func == (lhs: EpisodeFilters, rhs: EpisodeFilters) -> Bool {
        return lhs.name == rhs.name && lhs.seasonCode == rhs.seasonCode && lhs.episodeCode == rhs.episodeCode
    }
}
