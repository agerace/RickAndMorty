//
//  CharacterTests.swift
//  RickAndMortyTests
//
//  Created by César Gerace on 26/09/2023.
//

import XCTest

class CharacterTests: XCTestCase {
    func testCharacterFromJSONString() {
        let jsonString = """
        {
            "id": 1,
            "name": "Rick",
            "status": "Alive",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {
                "name": "Earth",
                "url": "https://rickandmortyapi.com/api/location/1"
            },
            "location": {
                "name": "Earth",
                "url": "https://rickandmortyapi.com/api/location/2"
            },
            "image": "https://rickandmortyapi.com/image",
            "episode": ["1"],
            "vantagePoints": []
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert JSON String to Data.")
            return
        }
        
        do {
            let character = try JSONDecoder().decode(Character.self, from: jsonData)
            
            XCTAssertEqual(character.id, 1)
            XCTAssertEqual(character.name, "Rick")
            XCTAssertEqual(character.status, .alive)
            XCTAssertEqual(character.species, "Human")
            XCTAssertEqual(character.type, "Unknown")
            XCTAssertEqual(character.gender, .male)
            XCTAssertEqual(character.originalLocation.name, "Earth")
            XCTAssertEqual(character.originalLocation.url, "https://rickandmortyapi.com/api/location/1")
            XCTAssertEqual(character.currentLocation.name, "Earth")
            XCTAssertEqual(character.currentLocation.url, "https://rickandmortyapi.com/api/location/2")
            XCTAssertEqual(character.imageUrl.absoluteString, "https://rickandmortyapi.com/image")
            XCTAssertEqual(character.appearances, 1)
        } catch {
            XCTFail("Failed to decode Character from JSON: \(error)")
        }
    }
}
