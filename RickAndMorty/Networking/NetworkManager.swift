//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by César Gerace on 25/09/2023.
//

import Foundation

enum RMError: String, Error {
    case genericError = "An error has ocurred. And that's the waaaay the news goes!"
    case serverError = "An error has ocurred on the server. Grasssssss... tastes bad!"
    case dataError = "There's an error with the data you are trying to GET. Lick lick lick my balls!"
    case emptyListError = "Oops, looks like there's nothing to show. Wubba Lubba Dub Dub!"
}

struct NetworkManager {
    let baseUrl = "https://rickandmortyapi.com/api/"
    
    func createRequest(resource: String, method: String = "GET", parameters: [String:String]? = nil) -> URLRequest {
        guard let url = URL(string: "\(baseUrl)\(resource)") else {
            return URLRequest(url: URL(string:"")!)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if let parameters = parameters {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        return request
    }
    
    func executeRequest(request: URLRequest) async -> Result<Data, RMError>{
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return .success(data)
        } catch {
            //TODO: Improve error handling
            return .failure(.genericError)
        }
    }
}
