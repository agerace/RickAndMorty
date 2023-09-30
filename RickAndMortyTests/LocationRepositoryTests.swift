//
//  LocationRepositoryTests.swift
//  RickAndMortyTests
//
//  Created by César Gerace on 26/09/2023.
//

import XCTest

class LocationRepositoryTests: XCTestCase {
    let locationRepository = LocationRepository()
    
    func testGetLocationWithIdSuccess() async {
        let expectation = XCTestExpectation(description: "Successful location retrieval")
        
        let result = await locationRepository.getLocationWith(id: "1")
        
        switch result {
        case .success(let location):
            XCTAssertNotNil(location)
        case .failure(_):
            XCTFail()
        }
        
            expectation.fulfill()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetLocationWithIdFailure() async {
        let expectation = XCTestExpectation(description: "Failed location retrieval")
        
       let result = await locationRepository.getLocationWith(id: "invalid_id")
        
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertNotNil(error)
        }
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 5.0)
    }
}
