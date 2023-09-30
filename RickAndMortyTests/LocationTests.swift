//
//  LocationTests.swift
//  RickAndMortyTests
//
//  Created by César Gerace on 26/09/2023.
//

import XCTest

class LocationTests: XCTestCase {
    func testLocationFromJSONString() {
        let jsonString = """
        {
            "id": 1,
            "name": "Test Location",
            "type": "Test Type",
            "dimension": "Test Dimension",
            "residents": ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"],
            "url": "https://rickandmortyapi.com/api/location/1"
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert JSON String to Data.")
            return
        }
        
        do {
            let location = try JSONDecoder().decode(Location.self, from: jsonData)
            
            XCTAssertEqual(location.id, 1)
            XCTAssertEqual(location.name, "Test Location")
            XCTAssertEqual(location.type, "Test Type")
            XCTAssertEqual(location.dimension, "Test Dimension")
            XCTAssertEqual(location.residents, ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"])
            XCTAssertEqual(location.url, "https://rickandmortyapi.com/api/location/1")
        } catch {
            XCTFail("Failed to decode Location from JSON: \(error)")
        }
    }
}

class ShortLocationTests: XCTestCase {
    func testShortLocationFromJSONString() {
        let jsonString = """
        {
            "name": "Test Short Location",
            "url": "https://rickandmortyapi.com/api/shortlocation/1"
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert JSON String to Data.")
            return
        }
        
        do {
            let shortLocation = try JSONDecoder().decode(ShortLocation.self, from: jsonData)
            
            XCTAssertEqual(shortLocation.name, "Test Short Location")
            XCTAssertEqual(shortLocation.url, "https://rickandmortyapi.com/api/shortlocation/1")
        } catch {
            XCTFail("Failed to decode ShortLocation from JSON: \(error)")
        }
    }
}
