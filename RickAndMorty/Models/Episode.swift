//
//  Episode.swift
//  RickAndMorty
//
//  Created by César Gerace on 30/09/2023.
//

import Foundation

enum SeasonCode: String, CaseIterable {
    case S01, S02, S03, S04, S05
    case allSeasons = "All Seasons"
}
enum EpisodeCode: String, CaseIterable {
    case E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11
    case allEpisodes = "All Episodes"
}

struct Episode: Decodable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episodeCode: String
    let charactersIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        
        case episodeCode = "episode"
        case airDate = "air_date"
        case charactersIds = "characters"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        episodeCode = try values.decode(String.self, forKey: .episodeCode)
        airDate = try values.decode(String.self, forKey: .airDate)
        
        let characterUrls = try values.decode([String].self, forKey: .charactersIds)
        charactersIds = characterUrls.compactMap{ $0.getIdFromUrl() }
    }
    
    init(sample: Bool = true) {
        id = 1
        name = "sampleChar"
        airDate = "December 2nd 2013"
        episodeCode = "S1E1"
        charactersIds = [1,2,3,4,5]
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id
    }
}
