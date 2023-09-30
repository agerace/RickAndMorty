//
//  LocationRepository.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import Foundation

struct LocationsListResult: Decodable {
    let results: [Location]
    let info: ResultInfo
}

struct LocationRepository {
    let manager = NetworkManager()
    private let locationResource = "location/"
    
    func getLocations(page: Int) async -> Result<[Location], RMError> {
        let manager = NetworkManager()
        let resource = locationResource + "?page=\(page)"
        let request = manager.createRequest(resource: resource)
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let locationListResult = try? JSONDecoder().decode(LocationsListResult.self, from: data) else {
                return .failure(.genericError)
            }
            return .success(locationListResult.results)
        }
    }
    
    func getLocationWith(id: String) async -> Result<Location, RMError> {
        let resource = locationResource + "\(id)"
        let request = manager.createRequest(resource: resource)
        let result = await manager.executeRequest(request: request)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let location = try? JSONDecoder().decode(Location.self, from: data) else {
                return .failure(.genericError)
            }
            return .success(location)
        }
    }
    
}
