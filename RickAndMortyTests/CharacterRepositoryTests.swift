//
//  CharacterRepositoryTests.swift
//  RickAndMortyTests
//
//  Created by César Gerace on 26/09/2023.
//

import XCTest

class CharacterRepositoryTests: XCTestCase {
    func testGetCharactersSuccess() async {
        let repository = CharacterRepository()
        let expectation = XCTestExpectation(description: "Successful character retrieval")
        
        let result = await repository.getCharacters(page: 1)
        
        switch result {
        case .success(let characters):
            XCTAssertNotNil(characters)
        case .failure(let error):
            XCTAssertNil(error)
        }
        expectation.fulfill()
            
            
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetCharactersFailure() async {
        let repository = CharacterRepository()
        let expectation = XCTestExpectation(description: "Failed character retrieval")
        
        let result = await repository.getCharacters(page: Int.max)
        
        switch result {
        case .success(let characters):
            XCTAssertNil(characters)
        case .failure(let error):
            XCTAssertNotNil(error)
        }
        
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 10.0)
    }
}
