//
//  Location.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import Foundation

struct Location: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    var residentsIds: [Int] {
        residents.compactMap{
            Int($0.split(separator: "/").last!)
        }
    }
    let url: String
    
    init(id: Int = 0, name: String = "", type: String = "", dimension: String = "", residents: [String] = [], url: String = "") {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
    }
}

extension Location: Equatable {
    
}

struct ShortLocation: Decodable {
    let name: String
    let url: String
    var id: Int? {
        Int(url.split(separator: "/").last ?? "-1")
    }
}
