//
//  Character.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import Foundation

enum CharacterStatus: String, Decodable, CaseIterable {
    case dead = "Dead"
    case alive = "Alive"
    case unknown = "Unknown"
    case allStatuses = "All Statuses"
}

enum CharacterGender: String, Decodable, CaseIterable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "Unknown"
    case allGenders = "All Genders"
}

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let originalLocation: ShortLocation
    let currentLocation: ShortLocation
    private let imageUrlString: String
    let imageUrl: URL
    let appearances: Int
    
    init(sample: Bool = true) {
        id = 1
        name = "sampleChar"
        status = .alive
        species = "Human"
        type = "Unknown"
        gender = .male
        originalLocation = ShortLocation(name: "Earth", url: "")
        currentLocation = ShortLocation(name: "Earth", url: "")
        imageUrlString = "imageUrlString"
        imageUrl = URL(string: "https://es.web.img3.acsta.net/pictures/18/10/31/17/34/2348073.jpg")!
        appearances = 15
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender
        
        case origin
        case episodes = "episode"
        case location
        case imageUrlString = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        
        let statusString = try values.decode(String.self, forKey: .status)
        status = CharacterStatus(rawValue: statusString) ?? .unknown
        
        species = try values.decode(String.self, forKey: .species)
        let typeString = try values.decode(String.self, forKey: .type)
        type = typeString == "" ? "Unknown" : typeString
        
        let genderString = try values.decode(String.self, forKey: .gender)
        gender = CharacterGender(rawValue: genderString) ?? .unknown
        
        
        let episodes = try values.decode([String].self, forKey: .episodes)
        appearances = episodes.count
        
        let origin = try values.decode([String:String].self, forKey: .origin)
        originalLocation = ShortLocation(name: origin["name"]!, url: origin["url"]!)
        
        let location = try values.decode([String:String].self, forKey: .location)
        currentLocation = ShortLocation(name: location["name"]!, url: location["url"]!)
        
        imageUrlString = try values.decode(String.self, forKey: .imageUrlString)
        imageUrl = URL(string: imageUrlString)!
        
    }
}

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}

