//
//  NetworkManagerTests.swift
//  RickAndMortyTests
//
//  Created by César Gerace on 26/09/2023.
//

import XCTest

class NetworkManagerTests: XCTestCase {
    
    func testCreateRequest() {
        let manager = NetworkManager()
        let request = manager.createRequest(resource: "character")
        
        XCTAssertEqual(request.url?.absoluteString, "https://rickandmortyapi.com/api/character")
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(request.allHTTPHeaderFields?["Accept"], "application/json; charset=utf-8")
    }
    
    func testExecuteRequestSuccess() async {
        let manager = NetworkManager()
        let expectation = XCTestExpectation(description: "Successful request")
        let request = manager.createRequest(resource: "character")
        
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .success(let data):
            XCTAssertNotNil(data)
        case .failure(_):
            XCTFail()
        }
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 5.0)
    }
    
}

