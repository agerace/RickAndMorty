//
//  ResultInfo.swift
//  RickAndMorty
//
//  Created by César Gerace on 29/09/2023.
//

import Foundation

struct ResultInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
