//
//  String+UrlExtension.swift
//  RickAndMorty
//
//  Created by César Gerace on 30/09/2023.
//

import Foundation

extension String {
    func getIdFromUrl() -> Int? {
        guard let id = self.split(separator: "/").last else { return nil }
        return Int(id)
    }
}
