//
//  Filter.swift
//  RickAndMorty
//
//  Created by César Gerace on 28/09/2023.
//

import Foundation

struct Filters {    
    var name: String = ""
    var status: CharacterStatus = .allStatuses
    var species: String = ""
    var type: String = ""
    var gender: CharacterGender = .allGenders
    
    func getFiltersAsQueryString() -> String {
        var queryFilters = [String]()
        
        if self.name != "" {
            queryFilters.append("name=\(name)")
        }
        if species != "" {
            queryFilters.append("species=\(species)")
        }
        if type != "" {
            queryFilters.append("type=\(type)")
        }
        if status != .allStatuses {
            queryFilters.append("status=\(status.rawValue)")
        }
        if gender != .allGenders {
            queryFilters.append("gender=\(gender.rawValue)")
        }
        
        var resource = "?"
        
        queryFilters.enumerated().forEach{ (index, filter) in
            if index != 0 {
                resource += "&"
            }
            resource += filter
        }
        return resource
    }
    
}

extension Filters: Equatable {
    static func == (lhs: Filters, rhs: Filters) -> Bool {
        return lhs.name == rhs.name && lhs.status == rhs.status && lhs.species == rhs.species && lhs.type == rhs.type && lhs.gender == rhs.gender
    }
}
